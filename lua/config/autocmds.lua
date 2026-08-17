-- =============================================================================
-- 1. Filetype Definitions & Setup
-- =============================================================================

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = { "*.tf", "*.tfvars", "*.tfstate" },
    callback = function()
        vim.bo.filetype = "terraform"
    end,
})

-- Auto-save on FocusLost
vim.api.nvim_create_autocmd("FocusLost", {
    callback = function()
        if vim.bo.buftype ~= "" then return end
        if vim.bo.modified then
            vim.cmd("silent! noautocmd write")
        end
    end,
})

-- Diagnostics configuration
vim.diagnostic.config({
    virtual_lines = {
        current_line = true, -- Only show virtual lines for current cursor line
    },
})

-- =============================================================================
-- 2. LSP Initialization (Neovim 0.11+ Native)
-- =============================================================================

-- Configure built-in LSP clients
vim.lsp.config('copilot', {
    settings = {
        telemetry = {
            telemetryLevel = "off",
        },
    },
})

-- Start your LSP servers
vim.lsp.enable({ 'lua_ls', 'copilot' })

-- =============================================================================
-- 3. Unified LspAttach Autocommands & Keymaps
-- =============================================================================

local lsp_group = vim.api.nvim_create_augroup("nvim_lsp_config", { clear = true })

-- Helper to set buffer-local keymaps cleanly
local function buffer_map(bufnr, mode, lhs, rhs, desc, opts)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { buffer = bufnr, desc = desc }, opts or {}))
end

-- Helper to toggle optional LSP features
local function toggle_feature(has_feature, enable, disable)
    if not has_feature then return end
    local enabled = enable()
    disable(not enabled)
end

vim.api.nvim_create_autocmd("LspAttach", {
    group = lsp_group,
    callback = function(event)
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if not client then return end

        -- Generic LSP navigation / action keymaps
        buffer_map(event.buf, "n", "K", vim.lsp.buf.hover, "LSP: Hover")
        buffer_map(event.buf, "n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
        buffer_map(event.buf, "n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
        buffer_map(event.buf, "n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
        buffer_map(event.buf, "n", "gr", vim.lsp.buf.references, "LSP: References")
        buffer_map(event.buf, "n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
        buffer_map(event.buf, { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")

        -- Toggle shortcuts for UI features
        buffer_map(event.buf, "n", "<leader>uh", function()
            toggle_feature(vim.lsp.inlay_hint, function()
                return vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
            end, function(enabled)
                vim.lsp.inlay_hint.enable(enabled, { bufnr = event.buf })
            end)
        end, "LSP: Toggle inlay hints")

        -- ---------------------------------------------------------------------
        -- Feature A: Native Standard Completion (Neovim 0.11+)
        -- ---------------------------------------------------------------------
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_completion) then
            vim.opt.completeopt = { 'menu', 'menuone', 'noinsert', 'fuzzy', 'popup' }
            vim.lsp.completion.enable(true, client.id, event.buf, { autotrigger = true })

            buffer_map(event.buf, 'i', '<C-Space>', function()
                vim.lsp.completion.get()
            end, "LSP: Trigger completion")
        end

        -- ---------------------------------------------------------------------
        -- Feature B: Native Inline Completion (AI / Copilot)
        -- ---------------------------------------------------------------------
        if vim.lsp.inline_completion and client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion) then
            vim.lsp.inline_completion.enable(true, { bufnr = event.buf })

            buffer_map(event.buf, "n", "<leader>uc", function()
                toggle_feature(vim.lsp.inline_completion, function()
                    return vim.lsp.inline_completion.is_enabled({ bufnr = event.buf })
                end, function(enabled)
                    vim.lsp.inline_completion.enable(enabled, { bufnr = event.buf })
                end)
            end, "LSP: Toggle inline completion")

            -- Accept with Alt+l (Highly recommended over Tab to avoid breaking normal indentation)
            buffer_map(event.buf, "i", "<M-l>", function()
                if vim.lsp.inline_completion.get() then
                    return ""
                end
                return "<M-l>"
            end, "LSP: Accept inline completion", { expr = true })

            -- Cycle through suggestions
            buffer_map(event.buf, "i", "<M-]>", function()
                vim.lsp.inline_completion.select({ count = 1 })
                return ""
            end, "LSP: Next suggestion", { expr = true })

            buffer_map(event.buf, "i", "<M-[>", function()
                vim.lsp.inline_completion.select({ count = -1 })
                return ""
            end, "LSP: Previous suggestion", { expr = true })
        end

        -- ---------------------------------------------------------------------
        -- Feature C: Signature Help
        -- ---------------------------------------------------------------------
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_signatureHelp) then
            buffer_map(event.buf, "n", "<C-s>", vim.lsp.buf.signature_help, "LSP: Signature help")
        end

        -- ---------------------------------------------------------------------
        -- Feature D: Document Highlight (Cursor Underlining)
        -- ---------------------------------------------------------------------
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_documentHighlight) then
            local highlight_group = vim.api.nvim_create_augroup("nvim_lsp_highlight_" .. event.buf, { clear = true })

            vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
                group = highlight_group,
                buffer = event.buf,
                callback = vim.lsp.buf.document_highlight,
            })

            vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
                group = highlight_group,
                buffer = event.buf,
                callback = vim.lsp.buf.clear_references,
            })

            vim.api.nvim_create_autocmd("LspDetach", {
                group = lsp_group,
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.clear_references()
                    pcall(vim.api.nvim_del_augroup_by_id, highlight_group)
                end,
            })
        end

        -- ---------------------------------------------------------------------
        -- Feature E: CodeLens
        -- ---------------------------------------------------------------------
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
            vim.lsp.codelens.enable(true, { bufnr = event.buf })
            buffer_map(event.buf, "n", "<leader>cl", vim.lsp.codelens.run, "LSP: Run CodeLens")
        end

        -- ---------------------------------------------------------------------
        -- Feature F: Formatting (Manual + Auto-format on Save)
        -- ---------------------------------------------------------------------
        if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
            -- Fallback formula for `=` key formatting
            vim.bo[event.buf].formatexpr = "v:lua.vim.lsp.formatexpr()"

            -- Manual format keymap
            buffer_map(event.buf, "n", "<leader>f", function()
                vim.lsp.buf.format({ async = true })
            end, "LSP: Format document")

            -- Auto-format on save
            vim.api.nvim_create_autocmd("BufWritePre", {
                group = lsp_group,
                buffer = event.buf,
                callback = function()
                    vim.lsp.buf.format({ bufnr = event.buf, id = client.id, async = false })
                end,
            })
        end
    end,
})

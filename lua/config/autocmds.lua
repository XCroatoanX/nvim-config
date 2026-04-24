-- Filetype-specific autocommands
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf", "*.tfvars", "*.tfstate" },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})

local lsp_group = vim.api.nvim_create_augroup("nvim_lsp_config", { clear = true })

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(event)
    local map = function(mode, lhs, rhs, desc, opts)
      vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { buffer = event.buf, desc = desc }, opts or {}))
    end

    map("n", "K", vim.lsp.buf.hover, "LSP: Hover")
    map("n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
    map("n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
    map("n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
    map("n", "gr", vim.lsp.buf.references, "LSP: References")
    map("n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
    map({ "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
    map("n", "<leader>f", function() vim.lsp.buf.format({ async = true }) end, "LSP: Format")
    map("n", "<leader>cl", function()
      vim.lsp.codelens.run()
    end, "LSP: Run CodeLens")
    map("n", "<leader>uh", function()
      if vim.lsp.inlay_hint then
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }), { bufnr = event.buf })
      end
    end, "LSP: Toggle inlay hints")
    map("n", "<leader>uc", function()
      if vim.lsp.inline_completion then
        local enabled = vim.lsp.inline_completion.is_enabled({ bufnr = event.buf })
        vim.lsp.inline_completion.enable(not enabled, { bufnr = event.buf })
      end
    end, "LSP: Toggle inline completion")

    map("i", "<Tab>", function()
      if vim.lsp.inline_completion then
        if vim.lsp.inline_completion.get() then
          return ""
        end
      end
      return "<Tab>"
    end, "LSP: Accept inline completion", { expr = true })
    map("i", "<M-]>", function()
      if vim.lsp.inline_completion then
        vim.lsp.inline_completion.select({ count = 1 })
      end
      return ""
    end, "LSP: Next inline completion", { expr = true })
    map("i", "<M-[>", function()
      if vim.lsp.inline_completion then
        vim.lsp.inline_completion.select({ count = -1 })
      end
      return ""
    end, "LSP: Previous inline completion", { expr = true })

    local client = vim.lsp.get_client_by_id(event.data.client_id)
    if not client then
      return
    end

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
        group = highlight_group,
        buffer = event.buf,
        callback = function()
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({ group = highlight_group, buffer = event.buf })
        end,
      })
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_codeLens) then
      vim.lsp.codelens.enable(true, { bufnr = event.buf })
    end

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_inlineCompletion, event.buf) and vim.lsp.inline_completion then
      vim.lsp.inline_completion.enable(true, { bufnr = event.buf })
    end
  end,
})


-- Filetype-specific autocommands
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf", "*.tfvars", "*.tfstate" },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})

local lsp_group = vim.api.nvim_create_augroup("nvim_lsp_config", { clear = true })

local function buffer_map(bufnr, mode, lhs, rhs, desc, opts)
  vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", { buffer = bufnr, desc = desc }, opts or {}))
end

local function toggle_feature(has_feature, enable, disable)
  if not has_feature then
    return
  end

  local enabled = enable()
  disable(not enabled)
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = lsp_group,
  callback = function(event)
    buffer_map(event.buf, "n", "K", vim.lsp.buf.hover, "LSP: Hover")
    buffer_map(event.buf, "n", "gd", vim.lsp.buf.definition, "LSP: Go to definition")
    buffer_map(event.buf, "n", "gD", vim.lsp.buf.declaration, "LSP: Go to declaration")
    buffer_map(event.buf, "n", "gi", vim.lsp.buf.implementation, "LSP: Go to implementation")
    buffer_map(event.buf, "n", "gr", vim.lsp.buf.references, "LSP: References")
    buffer_map(event.buf, "n", "<leader>rn", vim.lsp.buf.rename, "LSP: Rename")
    buffer_map(event.buf, { "n", "v" }, "<leader>ca", vim.lsp.buf.code_action, "LSP: Code action")
    buffer_map(event.buf, "n", "<leader>f", function()
      vim.lsp.buf.format({ async = true })
    end, "LSP: Format")
    buffer_map(event.buf, "n", "<leader>cl", vim.lsp.codelens.run, "LSP: Run CodeLens")
    buffer_map(event.buf, "n", "<leader>uh", function()
      toggle_feature(vim.lsp.inlay_hint, function()
        return vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf })
      end, function(enabled)
        vim.lsp.inlay_hint.enable(enabled, { bufnr = event.buf })
      end)
    end, "LSP: Toggle inlay hints")
    buffer_map(event.buf, "n", "<leader>uc", function()
      toggle_feature(vim.lsp.inline_completion, function()
        return vim.lsp.inline_completion.is_enabled({ bufnr = event.buf })
      end, function(enabled)
        vim.lsp.inline_completion.enable(enabled, { bufnr = event.buf })
      end)
    end, "LSP: Toggle inline completion")

    buffer_map(event.buf, "i", "<Tab>", function()
      if vim.lsp.inline_completion then
        if vim.lsp.inline_completion.get() then
          return ""
        end
      end
      return "<Tab>"
    end, "LSP: Accept inline completion", { expr = true })
    buffer_map(event.buf, "i", "<M-]>", function()
      if vim.lsp.inline_completion then
        vim.lsp.inline_completion.select({ count = 1 })
      end
      return ""
    end, "LSP: Next inline completion", { expr = true })
    buffer_map(event.buf, "i", "<M-[>", function()
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

    if client:supports_method(vim.lsp.protocol.Methods.textDocument_formatting) then
      vim.bo[event.buf].formatexpr = "v:lua.vim.lsp.formatexpr()"
    end
  end,
})

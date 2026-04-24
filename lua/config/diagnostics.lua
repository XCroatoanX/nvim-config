-- Global diagnostic configuration (signs, etc.)
vim.diagnostic.config({
  severity_sort = true,
  update_in_insert = false,
  virtual_text = {
    spacing = 2,
    source = "if_many",
    prefix = "●",
  },
  float = {
    border = "rounded",
    source = "if_many",
  },
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "\u{f057}",
      [vim.diagnostic.severity.WARN]  = "\u{f071}",
      [vim.diagnostic.severity.HINT]  = "\u{f834}",
      [vim.diagnostic.severity.INFO]  = "\u{f05a}",
    },
  },
})

vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focusable = false })
  end,
})

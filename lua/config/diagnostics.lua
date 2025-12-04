-- Global diagnostic configuration (signs, etc.)
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "\u{f057}",
      [vim.diagnostic.severity.WARN]  = "\u{f071}",
      [vim.diagnostic.severity.HINT]  = "\u{f834}",
      [vim.diagnostic.severity.INFO]  = "\u{f05a}",
    },
  },
})

vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })
require("gruvbox").setup({ contrast = "soft" })
vim.pack.add({ "https://github.com/nickkadutskyi/jb.nvim" })
require("jb").setup({})
vim.pack.add({ "https://github.com/Mofiqul/vscode.nvim" })
require("vscode").setup({ style = "dark" })
vim.cmd("colorscheme gruvbox")
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({ options = { theme = "gruvbox" } })
vim.pack.add({ "https://github.com/mawkler/onedark.nvim" })
vim.pack.add({ "https://github.com/mawkler/modicator.nvim" })
vim.o.cursorline = true
vim.o.number = true
vim.o.termguicolors = true
require("modicator").setup({ show_warnings = false, highlights = { defaults = { bold = true } } })

-- Bootstrap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)
vim.opt.termguicolors = true

-- General Neovim settings
vim.o.number = true
vim.o.relativenumber = true
vim.o.termguicolors = true
vim.o.expandtab = true
vim.o.shiftwidth = 2
vim.o.tabstop = 2

-- Normal mode
vim.keymap.set("n", "<C-_>", function()
  require("Comment.api").toggle.linewise.current()
end, { noremap = true, silent = true })

-- Visual mode
vim.keymap.set("v", "<C-_>", function()
  require("Comment.api").toggle.linewise(vim.fn.visualmode())
end, { noremap = true, silent = true })

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf", "*.tfvars", "*.tfstate" },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})


-- gutter LSP icons
vim.diagnostic.config({
  signs = {
    text = {
      [vim.diagnostic.severity.ERROR] = "",
      [vim.diagnostic.severity.WARN]  = "",
      [vim.diagnostic.severity.HINT]  = "",
      [vim.diagnostic.severity.INFO]  = "",
    },
  },
})


-- Load all plugins from plugins directory
require("lazy").setup("plugins")

vim.cmd([[autocmd VimEnter * Neotree]])

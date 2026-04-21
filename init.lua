vim.g.mapleader = " "
vim.g.maplocalleader = " "

vim.opt.termguicolors = true

-- Load core configuration (options, autocmds, diagnostics)
require('config')

-- Load all plugins from plugins directory using vim.pack
local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", true, true)
for _, file in ipairs(plugin_files) do
  dofile(file)
end

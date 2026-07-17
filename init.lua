vim.g.mapleader = " "
vim.g.maplocalleader = " "

-- only needed when using nvim-tree
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- Load core configuration (options, autocmds, diagnostics)
require('config')

-- Load all plugins from plugins directory using vim.pack
local plugin_files = vim.fn.glob(vim.fn.stdpath("config") .. "/lua/plugins/*.lua", true, true)
for _, file in ipairs(plugin_files) do
    dofile(file)
end

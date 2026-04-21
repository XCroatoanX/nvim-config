vim.pack.add({ "https://github.com/nvim-neotest/nvim-nio" })
vim.pack.add({ "https://github.com/theHamsta/nvim-dap-virtual-text" })
vim.pack.add({ "https://github.com/mfussenegger/nvim-dap" })
vim.pack.add({ "https://github.com/rcarriga/nvim-dap-ui" })
local dap, dapui = require("dap"), require("dapui")
dapui.setup()
dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
vim.pack.add({ "https://github.com/williamboman/mason.nvim" })
require("mason").setup()
vim.pack.add({ "https://github.com/jay-babu/mason-nvim-dap.nvim" })
local ok, mason_dap = pcall(require, "mason-nvim-dap")
if ok then mason_dap.setup({ ensure_installed = { "codelldb " }, automatic_installation = true }) end

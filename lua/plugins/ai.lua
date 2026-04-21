vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })
require("copilot").setup({ suggestion = { enabled = false }, panel = { enabled = false } })

vim.pack.add({ "https://github.com/folke/snacks.nvim" })
require("snacks").setup({ input = {}, picker = {}, terminal = {} })

vim.pack.add({ "https://github.com/NickvanDyke/opencode.nvim" })
vim.g.opencode_opts = { port = 3923 }
vim.o.autoread = true
local map = vim.keymap.set
map({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
map({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute action" })
map({ "n", "x" }, "ga", function() require("opencode").prompt("@this") end, { desc = "Add to context" })
map({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
map('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
map('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })

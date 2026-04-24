vim.pack.add({ "https://github.com/folke/snacks.nvim" })
vim.pack.add({ "https://github.com/nickjvandyke/opencode.nvim" })

require("snacks").setup({
    input = {
        win = {
            border = "rounded",
        },
    },
    terminal = {},
    picker = {
        ui_select = true,
        actions = {
            opencode_send = function(...) 
                return require("opencode").snacks_picker_send(...) 
            end,
        },
        win = {
            input = {
                keys = {
                    ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
            },
        },
    },
})

vim.g.opencode_opts = {}
vim.o.autoread = true 

local opencode = require("opencode")

-- Keymaps
vim.keymap.set({ "n", "x" }, "<leader>oa", function() opencode.ask("@this: ", { submit = true }) end, { desc = "Ask opencode…" })
vim.keymap.set({ "n", "x" }, "<leader>ox", function() opencode.select() end,                            { desc = "Execute opencode action…" })
vim.keymap.set({ "n", "t" }, "<C-.>", function() opencode.toggle() end,                          { desc = "Toggle opencode" })

vim.keymap.set({ "n", "x" }, "go",  function() return opencode.operator("@this ") end,        { desc = "Add range to opencode", expr = true })
vim.keymap.set("n",          "goo", function() return opencode.operator("@this ") .. "_" end, { desc = "Add line to opencode", expr = true })

vim.keymap.set("n", "<S-C-u>", function() opencode.command("session.half.page.up") end,   { desc = "Scroll opencode up" })
vim.keymap.set("n", "<S-C-d>", function() opencode.command("session.half.page.down") end, { desc = "Scroll opencode down" })

vim.keymap.set("n", "+", "<C-a>", { desc = "Increment under cursor", noremap = true })
vim.keymap.set("n", "-", "<C-x>", { desc = "Decrement under cursor", noremap = true })

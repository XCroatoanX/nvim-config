vim.pack.add({ { src = 'https://github.com/nvim-tree/nvim-tree.lua' } })

require("nvim-tree").setup({
    renderer = {
        indent_markers = {
            enable = true
        },
    },
})

vim.keymap.set("n", "<M-e>", "<cmd>NvimTreeToggle<CR>",
    { noremap = true, silent = true, desc = "Toggle file explorer" })

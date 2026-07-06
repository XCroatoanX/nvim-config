vim.pack.add({
    {
        src = 'https://github.com/nvim-neo-tree/neo-tree.nvim',
        version = vim.version.range('3')
    },
})

require("neo-tree").setup({
    popup_border_style = "rounded",
})
vim.keymap.set("n", "<C-e>", "<cmd>Neotree toggle<CR>", { noremap = true, silent = true, desc = "Toggle file explorer" })

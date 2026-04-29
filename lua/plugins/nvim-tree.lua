vim.pack.add({ "https://github.com/nvim-tree/nvim-tree.lua" })
require("nvim-tree").setup()
vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle file explorer" })

vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
vim.pack.add({ "https://github.com/nvim-lua/plenary.nvim" })
vim.pack.add({ "https://github.com/nvim-tree/nvim-tree.lua" })
require("nvim-tree").setup({
  hijack_cursor = true, sync_root_with_cwd = true, respect_buf_cwd = true,
  update_focused_file = { enable = true, update_root = true },
  view = { side = "right", width = 35 },
  renderer = { group_empty = true },
  filters = { dotfiles = false, git_ignored = false },
})
vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", { noremap = true, silent = true, desc = "Toggle file explorer" })
vim.pack.add({ "https://github.com/antosha417/nvim-lsp-file-operations" })
require("lsp-file-operations").setup()

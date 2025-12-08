return {
  {
    "nvim-tree/nvim-tree.lua",
    version = "*",
    lazy = false,
    dependencies = {
      "nvim-tree/nvim-web-devicons",
      "nvim-lua/plenary.nvim",
    },
    config = function()
      require("nvim-tree").setup({
        hijack_cursor = true,
        sync_root_with_cwd = true,
        respect_buf_cwd = true,
        update_focused_file = {
          enable = true,
          update_root = true,
        },
        view = {
          side = "right",
          width = 35,
        },
        renderer = {
          group_empty = true,
        },
        filters = {
          dotfiles = false,
          git_ignored = false,
        },
      })

      -- Toggle nvim-tree with Ctrl+E
      vim.keymap.set("n", "<C-e>", "<cmd>NvimTreeToggle<CR>", {
        noremap = true,
        silent = true,
        desc = "Toggle file explorer",
      })
    end,
  },
  {
    "antosha417/nvim-lsp-file-operations",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-tree.lua",
    },
    config = function()
      require("lsp-file-operations").setup()
    end,
  },
}

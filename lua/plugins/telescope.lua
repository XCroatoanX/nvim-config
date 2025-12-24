-- telescope, basically a fuzzy finder
return {
  {
    "nvim-telescope/telescope.nvim",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-telescope/telescope-fzy-native.nvim",
      "tsakirist/telescope-lazy.nvim",
    },
    config = function()
      local telescope = require("telescope")
      local actions = require("telescope.actions")

      telescope.setup({
        defaults = {
          prompt_prefix = "🔍 ",
          selection_caret = "➤ ",
          path_display = { "smart" },
          sorting_strategy = "ascending",
          layout_strategy = "horizontal",
          layout_config = {
            horizontal = { prompt_position = "top", preview_width = 0.55 },
            vertical = { width = 0.5, height = 0.8, preview_height = 0.5 },
            width = 0.87,
            height = 0.80,
            preview_cutoff = 120,
          },
          mappings = {
            i = {
              ["<C-n>"] = actions.cycle_history_next,
              ["<C-p>"] = actions.cycle_history_prev,
              ["<C-j>"] = actions.move_selection_next,
              ["<C-k>"] = actions.move_selection_previous,
              ["<C-c>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
              ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse,
              ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better,
            },
            n = {
              ["<esc>"] = actions.close,
              ["<CR>"] = actions.select_default,
              ["<C-x>"] = actions.select_horizontal,
              ["<C-v>"] = actions.select_vertical,
              ["<C-t>"] = actions.select_tab,
            },
          },
        },
        pickers = {
          find_files = { theme = "dropdown", hidden = true },
          buffers = { theme = "dropdown", previewer = false },
        },
        extensions = {
          fzy_native = {
            override_generic_sorter = false,
            override_file_sorter = true,
          },
        },
      })

      pcall(telescope.load_extension, "fzy_native")

      local builtin = require("telescope.builtin")
      local map = vim.keymap.set
      map("n", "<leader>ff", builtin.find_files, { desc = "Telescope find files" })
      map("n", "<leader>fg", builtin.live_grep, { desc = "Telescope live grep" })
      map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
      map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
      map("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope old files" })
    end,
  },
}

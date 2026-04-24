vim.pack.add({ "https://github.com/tsakirist/telescope-lazy.nvim" })
vim.pack.add({ "https://github.com/nvim-telescope/telescope-fzy-native.nvim" })
vim.pack.add({ "https://github.com/nvim-telescope/telescope.nvim" })
local telescope = require("telescope")
local actions = require("telescope.actions")
local root = require("config.root")
telescope.setup({
  defaults = {
    prompt_prefix = "🔍 ", selection_caret = "➤ ", path_display = { "smart" },
    sorting_strategy = "ascending", layout_strategy = "horizontal",
    layout_config = { horizontal = { prompt_position = "top", preview_width = 0.55 }, vertical = { width = 0.5, height = 0.8, preview_height = 0.5 }, width = 0.87, height = 0.80, preview_cutoff = 120 },
    mappings = {
      i = { ["<C-n>"] = actions.cycle_history_next, ["<C-p>"] = actions.cycle_history_prev, ["<C-j>"] = actions.move_selection_next, ["<C-k>"] = actions.move_selection_previous, ["<C-c>"] = actions.close, ["<CR>"] = actions.select_default, ["<C-x>"] = actions.select_horizontal, ["<C-v>"] = actions.select_vertical, ["<C-t>"] = actions.select_tab, ["<Tab>"] = actions.toggle_selection + actions.move_selection_worse, ["<S-Tab>"] = actions.toggle_selection + actions.move_selection_better },
      n = { ["<esc>"] = actions.close, ["<CR>"] = actions.select_default, ["<C-x>"] = actions.select_horizontal, ["<C-v>"] = actions.select_vertical, ["<C-t>"] = actions.select_tab },
    },
  },
  pickers = { find_files = { theme = "dropdown", hidden = true }, buffers = { theme = "dropdown", previewer = false } },
  extensions = { fzy_native = { override_generic_sorter = false, override_file_sorter = true } },
})
pcall(telescope.load_extension, "fzy_native")
local builtin = require("telescope.builtin")
local map = vim.keymap.set
map("n", "<leader>ff", function()
  builtin.find_files({ cwd = root.get(0) })
end, { desc = "Telescope find files (project root)" })
map("n", "<leader>fg", function()
  builtin.live_grep({ cwd = root.get(0) })
end, { desc = "Telescope live grep (project root)" })
map("n", "<leader>fb", builtin.buffers, { desc = "Telescope buffers" })
map("n", "<leader>fh", builtin.help_tags, { desc = "Telescope help tags" })
map("n", "<leader>fo", builtin.oldfiles, { desc = "Telescope old files" })

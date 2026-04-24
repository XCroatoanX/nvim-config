vim.pack.add({ "https://github.com/MunifTanjim/nui.nvim" })
vim.pack.add({ "https://github.com/rcarriga/nvim-notify" })
vim.pack.add({ "https://github.com/folke/noice.nvim" })
require("notify").setup({ background_colour = "#282828" })
require("noice").setup({
  lsp = {
    override = {
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  presets = {
    bottom_search = true,
    command_palette = false,
    long_message_to_split = true,
    inc_rename = false,
    lsp_doc_border = false,
  },
})
vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })
require("gruvbox").setup({ contrast = "soft" })
vim.cmd("colorscheme gruvbox")
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require("lualine").setup({
  options = { theme = "gruvbox" },
})
vim.pack.add({ "https://github.com/mawkler/modicator.nvim" })
vim.opt.cursorline = true
vim.opt.number = true
vim.opt.termguicolors = true
require("modicator").setup({
  show_warnings = false,
  highlights = { defaults = { bold = true } },
})
vim.pack.add({ "https://github.com/sphamba/smear-cursor.nvim" })
require("smear_cursor").setup({})
vim.pack.add({ "https://github.com/rachartier/tiny-glimmer.nvim" })
require("tiny-glimmer").setup()
vim.pack.add({ "https://github.com/petertriho/nvim-scrollbar" })
require("scrollbar").setup()
vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup({})
vim.keymap.set("n", "<leader>?", function()
  require("which-key").show({ global = false })
end, { desc = "Buffer Local Keymaps (which-key)" })

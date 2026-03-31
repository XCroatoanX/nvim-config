vim.pack.add({ "https://github.com/MunifTanjim/nui.nvim" })
vim.pack.add({ "https://github.com/rcarriga/nvim-notify" })
vim.pack.add({ "https://github.com/folke/noice.nvim" })
require("notify").setup({ background_colour = "#282828" })
require("noice").setup({ lsp = { override = { ["vim.lsp.util.convert_input_to_markdown_lines"] = true, ["vim.lsp.util.stylize_markdown"] = true, ["cmp.entry.get_documentation"] = true } }, presets = { bottom_search = true, command_palette = false, long_message_to_split = true, inc_rename = false, lsp_doc_border = false } })
vim.pack.add({ "https://github.com/ellisonleao/gruvbox.nvim" })
require("gruvbox").setup({ contrast = "soft" })
vim.pack.add({ "https://github.com/nickkadutskyi/jb.nvim" })
require("jb").setup({})
vim.pack.add({ "https://github.com/Mofiqul/vscode.nvim" })
require("vscode").setup({ style = "dark" })
vim.cmd("colorscheme gruvbox")
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/SmiteshP/nvim-navic" })
local navic_ok, navic = pcall(require, 'nvim-navic')
if navic_ok then
  navic.setup({ highlight = true, separator = " > ", depth_limit = 5, lazy_update_context = true, auto_attach = true })
  _G.navic_winbar = function()
    if require('nvim-navic').is_available() then
      return require('nvim-navic').get_location()
    end
    return ''
  end
  vim.o.winbar = "%f %{%v:lua.navic_winbar()%}"
end
vim.pack.add({ "https://github.com/nvim-lualine/lualine.nvim" })
require('lualine').setup({
  options = { theme = 'gruvbox' },
  sections = { lualine_c = { 'filename', { function() if navic_ok and navic.is_available() then return navic.get_location() end return '' end, cond = function() return navic_ok and navic.is_available() end } } },
})
vim.pack.add({ "https://github.com/mawkler/onedark.nvim" })
vim.pack.add({ "https://github.com/mawkler/modicator.nvim" })
vim.o.cursorline = true; vim.o.number = true; vim.o.termguicolors = true
require("modicator").setup({ show_warnings = false, highlights = { defaults = { bold = true } } })
vim.pack.add({ "https://github.com/sphamba/smear-cursor.nvim" })
require("smear_cursor").setup({})
vim.pack.add({ "https://github.com/rachartier/tiny-glimmer.nvim" })
require("tiny-glimmer").setup()
vim.pack.add({ "https://github.com/petertriho/nvim-scrollbar" })
require("scrollbar").setup()
vim.pack.add({ "https://github.com/folke/which-key.nvim" })
require("which-key").setup({})
vim.keymap.set("n", "<leader>?", function() require("which-key").show({ global = false }) end, { desc = "Buffer Local Keymaps (which-key)" })

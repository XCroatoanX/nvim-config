-- Plugin specification
return {
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          -- available: vscode, gruvbox
          theme = 'vscode',
        },
      })
    end,
  },
  {
    "karb94/neoscroll.nvim",
    opts = {},
  },
  {
    'mawkler/modicator.nvim',
    dependencies = 'mawkler/onedark.nvim', -- Add your colorscheme plugin here
    init = function()
      -- These are required for Modicator to work
      vim.o.cursorline = true
      vim.o.number = true
      vim.o.termguicolors = true
    end,
    event = 'ModeChanged',
    opts = {
      show_warnings = false,
      highlights = { defaults = { bold = true }, },
    }
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    main = "ibl",
    ---@module "ibl"
    ---@type ibl.config
    opts = {},
  },
  {
    "HiPhish/rainbow-delimiters.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
  },
}

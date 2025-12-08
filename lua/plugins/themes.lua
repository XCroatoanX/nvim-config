-- ~/.config/nvim/lua/plugins/colorschemes.lua
return {
  -- Gruvbox theme
  {
    "ellisonleao/gruvbox.nvim",
    lazy = false,
    priority = 1000,
    opts = {
      contrast = "soft", -- optional
    }
  },

  -- JB theme
  {
    "nickkadutskyi/jb.nvim",
    lazy = false,
    priority = 900,
    opts = {},
  },

  -- VSCode theme
  {
    "Mofiqul/vscode.nvim",
    lazy = false,
    priority = 800,
    opts = {
      style = "dark", -- "dark" or "light"
    },
    config = function()
      vim.cmd("colorscheme gruvbox") -- <-- apply after plugin loads
    end,
  },
  -- Lualine statusline
  {
    'nvim-lualine/lualine.nvim',
    config = function()
      require('lualine').setup({
        options = {
          -- available: vscode, gruvbox
          theme = 'gruvbox',
        },
      })
    end,
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


}

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
}

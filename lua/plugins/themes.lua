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
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    config = function()
      require('lualine').setup({
        options = { theme = 'gruvbox' },
        sections = {
          lualine_z = {
            {
              -- Shows AI status (Idle, Thinking, etc.)
              function()
                local ok, opencode = pcall(require, "opencode")
                return ok and opencode.statusline() or ""
              end,
              color = { fg = "#fe8019" }, -- Gruvbox Orange
            },
          }
        }
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

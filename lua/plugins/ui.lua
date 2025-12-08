return {
  -- Nice nvim UI for messages, cmdline and the popupmenu
  {
    "folke/noice.nvim",
    event = "VeryLazy",
    dependencies = {
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-notify",
    },
    config = function()
      -- Setup notify first
      require("notify").setup({
        background_colour = "#282828", -- Gruvbox dark background
      })

      -- Then setup noice
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
    end,
  },

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

  -- Modicator: A minimal mode indicator for Neovim
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

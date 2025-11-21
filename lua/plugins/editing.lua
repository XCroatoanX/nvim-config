return {
  -- nvim-autopairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
  },

  -- lspkind for pictograms in completions
  {
    "onsails/lspkind-nvim",
    lazy = false,
  },

  -- Commenting plugin
  {
    'numToStr/Comment.nvim',
    opts = {},
  },

  -- todo-comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
    opts = {},
  },

  -- Git signs
  {
    "lewis6991/gitsigns.nvim",
    opts = {},
  },
  -- Hide API keys
  {
    "laytan/cloak.nvim",
    lazy = true,                            -- optional, loads on BufRead/BufNewFile
    event = { "BufReadPre", "BufNewFile" }, -- lazy load when opening files
    config = function()
      require('cloak').setup({
        enabled = true,
        cloak_character = '*',
        highlight_group = 'Comment',
        cloak_length = nil,
        try_all_patterns = true,
        cloak_telescope = true,
        cloak_on_leave = false,
        patterns = {
          {
            file_pattern = '.env*',
            cloak_pattern = '=.+',
            replace = nil,
          },
        },
      })
    end,
  },

  -- Copilot
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp", -- optional: NES functionality
    },
    cmd = "Copilot",                 -- lazy-load when :Copilot is used
    event = "InsertEnter",           -- lazy-load when entering insert mode
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<C-j>",
            prev = "<C-k>",
            dismiss = "<C-]>",
          },
        },                               -- enable ghost text
        panel = { auto_refresh = true }, -- enable the Copilot panel
        nes = { enabled = false, auto_trigger = true },
      })
    end,
  },
}

return {
  -- nvim-autopairs
  {
    'windwp/nvim-autopairs',
    event = "InsertEnter",
    config = true,
  },

  -- Commenting plugin
  {
    'numToStr/Comment.nvim',
    opts = {},
    config = function()
      require('Comment').setup()
      -- Normal mode toggle
      vim.keymap.set('n', '<C-_>', function()
        require('Comment.api').toggle.linewise.current()
      end, { noremap = true, silent = true })
      -- Visual mode toggle
      vim.keymap.set('v', '<C-_>', function()
        require('Comment.api').toggle.linewise(vim.fn.visualmode())
      end, { noremap = true, silent = true })
    end,
  },

  -- todo-comments
  {
    "folke/todo-comments.nvim",
    dependencies = { "nvim-lua/plenary.nvim" },
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
  -- Auto close and rename html tags
  {
  "windwp/nvim-ts-autotag"
}
}

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
}


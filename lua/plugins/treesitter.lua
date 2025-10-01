return {
  "nvim-treesitter/nvim-treesitter",
  build = ":TSUpdate",
  lazy = false,
  config = function()
    require("nvim-treesitter.configs").setup {
      highlight = { enable = true, additional_vim_regex_highlighting = false },
    }
  end,
}
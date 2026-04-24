vim.pack.add({ "https://github.com/j-hui/fidget.nvim" })

require("fidget").setup({
  progress = {
    display = {
      done_icon = "",
      progress_icon = { "dots" },
    },
  },
  notification = {
    window = {
      winblend = 0,
    },
  },
})

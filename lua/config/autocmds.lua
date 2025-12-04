-- Filetype-specific autocommands
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
  pattern = { "*.tf", "*.tfvars", "*.tfstate" },
  callback = function()
    vim.bo.filetype = "terraform"
  end,
})

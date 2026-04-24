local function update_packages()
  vim.pack.update()
end

local command_opts = { desc = "Update vim.pack packages" }

vim.api.nvim_create_user_command("PackUpdate", update_packages, command_opts)
vim.api.nvim_create_user_command("PU", update_packages, command_opts)

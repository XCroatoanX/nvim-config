local M = {}

local root_markers = {
  ".git",
  "lua",
  "package.json",
  "pyproject.toml",
  "go.mod",
  "Cargo.toml",
  "Makefile",
}

function M.get(bufnr)
  local buffer = bufnr or 0
  local path = vim.api.nvim_buf_get_name(buffer)
  local cwd = (vim.uv and vim.uv.cwd()) or vim.fn.getcwd()
  if path == "" then
    return cwd
  end

  local root = vim.fs.root(path, root_markers)
  return root or vim.fs.dirname(path) or cwd
end

function M.cd(bufnr)
  local root = M.get(bufnr)
  vim.cmd.cd(vim.fn.fnameescape(root))
  vim.notify("cwd -> " .. root, vim.log.levels.INFO, { title = "Project root" })
end

vim.api.nvim_create_user_command("ProjectRoot", function()
  M.cd(0)
end, { desc = "Set cwd to current buffer project root" })

vim.api.nvim_create_user_command("ProjectRootPrint", function()
  vim.notify(M.get(0), vim.log.levels.INFO, { title = "Project root" })
end, { desc = "Print current buffer project root" })

return M

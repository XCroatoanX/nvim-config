local session_file = vim.fn.stdpath("state") .. "/session.vim"

local function session_exists()
  return vim.fn.filereadable(session_file) == 1
end

local function save_session()
  vim.fn.mkdir(vim.fn.fnamemodify(session_file, ":h"), "p")
  vim.cmd("mksession! " .. vim.fn.fnameescape(session_file))
  vim.notify("Session saved", vim.log.levels.INFO, { title = "Session" })
end

local function load_session()
  if not session_exists() then
    vim.notify("No session found", vim.log.levels.WARN, { title = "Session" })
    return
  end
  vim.cmd("silent! source " .. vim.fn.fnameescape(session_file))
  vim.notify("Session loaded", vim.log.levels.INFO, { title = "Session" })
end

local function delete_session()
  if session_exists() then
    vim.fn.delete(session_file)
    vim.notify("Session deleted", vim.log.levels.INFO, { title = "Session" })
  else
    vim.notify("No session to delete", vim.log.levels.WARN, { title = "Session" })
  end
end

vim.api.nvim_create_user_command("SessionSave", save_session, { desc = "Save current session" })
vim.api.nvim_create_user_command("SessionLoad", load_session, { desc = "Load saved session" })
vim.api.nvim_create_user_command("SessionDelete", delete_session, { desc = "Delete saved session" })

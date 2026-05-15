vim.keymap.set('n', '<C-h>', '<C-w>h', { desc = 'Move focus to the left window' })
vim.keymap.set('n', '<C-l>', '<C-w>l', { desc = 'Move focus to the right window' })
vim.keymap.set('n', '<leader>pr', '<cmd>ProjectRoot<cr>', { desc = 'Set project root cwd' })
vim.keymap.set('n', '<leader>pp', '<cmd>ProjectRootPrint<cr>', { desc = 'Print project root' })
vim.keymap.set('n', '<leader>ss', '<cmd>SessionSave<cr>', { desc = 'Save session' })
vim.keymap.set('n', '<leader>sl', '<cmd>SessionLoad<cr>', { desc = 'Load session' })
vim.keymap.set('n', '<leader>sd', '<cmd>SessionDelete<cr>', { desc = 'Delete session' })
vim.keymap.set('i', '<C-CR>', function()
  if not vim.lsp.inline_completion.get() then
    return '<CR>'
  end
end, { expr = true, replace_keycodes = true, desc = 'Accept LSP inline completion or insert newline' })

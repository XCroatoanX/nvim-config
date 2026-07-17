local opt = vim.opt

local options = {
    number = true,
    relativenumber = true,
    termguicolors = true,
    expandtab = true,
    shiftwidth = 4,
    tabstop = 4,
    smartindent = true,
    mouse = "a",
    clipboard = "unnamedplus",
    ignorecase = true,
    smartcase = true,
    cursorline = true,
    signcolumn = "yes",
    scrolloff = 8,
    sidescrolloff = 8,
    updatetime = 250,
    timeoutlen = 300,
    mousemoveevent = true,
}

for k, v in pairs(options) do
    opt[k] = v
end

-- Special cases that require methods instead of direct assignment
vim.opt.listchars:append({ space = ' ', trail = '»' })

vim.o.autowriteall = true

vim.api.nvim_create_autocmd({ "InsertLeave", "TextChanged" }, {
    pattern = "*",
    callback = function()
        if vim.bo.modifiable and not vim.bo.readonly and vim.bo.buftype == "" then
            vim.cmd("silent! update")
        end
    end,
})

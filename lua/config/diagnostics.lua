-- Global diagnostic configuration (signs, etc.)
vim.diagnostic.config({
    severity_sort = true,
    update_in_insert = false,
    virtual_text = {
        spacing = 2,
        source = "if_many",
        prefix = "●",
    },
    float = {
        border = "rounded",
        source = "if_many",
    },
    signs = {
        text = {
            [vim.diagnostic.severity.ERROR] = " ",
            [vim.diagnostic.severity.WARN]  = " ",
            [vim.diagnostic.severity.INFO]  = " ",
            [vim.diagnostic.severity.HINT]  = "󰌵 ",
        },
    },
})

vim.api.nvim_create_autocmd("CursorHold", {
    callback = function()
        if vim.bo.buftype ~= "" then
            return
        end
        vim.diagnostic.open_float(nil, { focusable = false })
    end,
})

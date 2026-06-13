vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })
require("render-markdown").setup({})

vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
require("ibl").setup({})

vim.pack.add({ "https://github.com/HiPhish/rainbow-delimiters.nvim" })

vim.api.nvim_create_autocmd("FileType", {
    pattern = "*",
    callback = function(args)
        local lang = vim.bo[args.buf].filetype
        local blacklist = {
            [""] = true,
            NvimTree = true,
            TelescopePrompt = true,
            TelescopeResults = true,
            fidget = true,
            mason = true,
            lazy = true,
            lspinfo = true,
        }

        if blacklist[lang] then
            return
        end

        local buftype = vim.bo[args.buf].buftype
        if buftype == "nofile" or buftype == "terminal" or buftype == "prompt" then
            return
        end

        pcall(vim.treesitter.start, args.buf, lang)
    end,
})

vim.keymap.set("n", "<C-space>", function()
    vim.cmd("normal! v")
end, { desc = "Init Selection" })

vim.keymap.set("x", "<C-space>", function()
    local node = vim.treesitter.get_node()
    if node and node:parent() then
        local range = { node:parent():range() }
        vim.api.nvim_win_set_cursor(0, { range[1] + 1, range[2] })
        vim.cmd("normal! o")
        vim.api.nvim_win_set_cursor(0, { range[3] + 1, range[4] })
    end
end, { desc = "Increment Node" })

vim.pack.add({ "https://github.com/linux-cultist/venv-selector.nvim" })
local venv_selector = require("venv-selector")
venv_selector.setup({
    ft = "python",
    keys = {
        { ",v", "<cmd>VenvSelect<cr>", desc = "Select Python virtual environment" },
    },
    opts = {
        options = {

        },
        search = {

        }
    }
})

return {
    "stevearc/conform.nvim",
    event = "BufWritePre",
    config = function()
        require("conform").setup({
        format_on_save = {
            lsp_format = "fallback",
            timeout_ms = 500,
        },
        default_format_opts = {
            lsp_format = "fallback",
            stop_after_first = true,
        },
        })
    end,
}
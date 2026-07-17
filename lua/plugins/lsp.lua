vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup({})

vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })

local mason_lspconfig = require("mason-lspconfig")

local capabilities = vim.lsp.protocol.make_client_capabilities()
local ok_blink, blink = pcall(require, "blink.cmp")
if ok_blink then
    capabilities = blink.get_lsp_capabilities(capabilities)
end

vim.lsp.config("yamlls", {
    capabilities = capabilities,
    settings = {
        yaml = {
            schemas = {
                kubernetes = { "k8s/*.yaml", "deploy/**/*.yaml", "deployment*.yaml" }
            }
        },
    },
})

if vim.fn.executable("copilot-language-server") == 1 then
    vim.lsp.config("copilot", {
        capabilities = capabilities,
        workspace_required = false,
        settings = {
            telemetry = {
                telemetryLevel = "off",
            }
        }
    })
end


mason_lspconfig.setup({
    ensure_installed = { "yamlls", "copilot" },
})

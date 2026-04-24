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

local function setup_server(server_name, opts)
  vim.lsp.config(server_name, vim.tbl_deep_extend("force", {
    capabilities = capabilities,
  }, opts or {}))
  vim.lsp.enable(server_name)
end

local special_servers = {
  yamlls = true,
  copilot = true,
}

mason_lspconfig.setup({
  ensure_installed = { "yamlls" },
  automatic_installation = true,
})

setup_server("yamlls", {
  settings = {
    yaml = {
      schemas = {
        ["kubernetes"] = "/*.yaml",
      },
    },
  },
})

if vim.fn.executable("copilot-language-server") == 1 then
  setup_server("copilot", {
    workspace_required = false,
  })
end

for _, server_name in ipairs(mason_lspconfig.get_installed_servers()) do
  if not special_servers[server_name] then
    setup_server(server_name)
  end
end

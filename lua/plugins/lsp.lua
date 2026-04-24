vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup({})
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })

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

require("mason-lspconfig").setup({})
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

for _, server_name in ipairs(require("mason-lspconfig").get_installed_servers()) do
  if server_name ~= "yamlls" and server_name ~= "copilot" then
    setup_server(server_name)
  else
    if server_name == "yamlls" then
      vim.lsp.enable("yamlls")
    end
  end
end

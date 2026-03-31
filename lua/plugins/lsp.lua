vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup({})
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/SmiteshP/nvim-navic" })
vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })
local navic = require("nvim-navic")
local lspconfig = require("lspconfig")
local on_attach = function(client, bufnr)
  if client.server_capabilities.documentSymbolProvider then
    navic.attach(client, bufnr)
  end
end
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({
        on_attach = on_attach,
      })
    end,
  },
})

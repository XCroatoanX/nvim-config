return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
    "SmiteshP/nvim-navic",
  },
  config = function()
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
  end,
}

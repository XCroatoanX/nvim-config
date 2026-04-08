return {
  "mason-org/mason-lspconfig.nvim",
  dependencies = {
    { "mason-org/mason.nvim", opts = {} },
    "neovim/nvim-lspconfig",
  },
  config = function()
    local lspconfig = require("lspconfig")

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

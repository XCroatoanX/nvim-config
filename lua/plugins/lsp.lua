vim.pack.add({ "https://github.com/mason-org/mason.nvim" })
require("mason").setup({})
vim.pack.add({ "https://github.com/neovim/nvim-lspconfig" })
vim.pack.add({ "https://github.com/mason-org/mason-lspconfig.nvim" })
local lspconfig = require("lspconfig")
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      lspconfig[server_name].setup({})
    end,
  },
})

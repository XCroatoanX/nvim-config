vim.pack.add({ "https://github.com/nvim-treesitter/nvim-treesitter" })

vim.pack.add({ "https://github.com/MeanderingProgrammer/render-markdown.nvim" })
require("render-markdown").setup({})
vim.pack.add({ "https://github.com/lukas-reineke/indent-blankline.nvim" })
require("ibl").setup({})
vim.pack.add({ "https://github.com/HiPhish/rainbow-delimiters.nvim" })

local ok, treesitter_configs = pcall(require, "nvim-treesitter.configs")
if ok then
  treesitter_configs.setup({
    highlight = { enable = true },
    indent = { enable = true },
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<C-space>",
        node_incremental = "<C-space>",
        scope_incremental = "<C-s>",
        node_decremental = "<M-space>",
      },
    },
  })
end

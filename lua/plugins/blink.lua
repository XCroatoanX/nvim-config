vim.pack.add({ "https://github.com/xzbdmw/colorful-menu.nvim" })
vim.pack.add({ "https://github.com/L3MON4D3/LuaSnip" })
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })
vim.pack.add({ "https://github.com/onsails/lspkind-nvim" })
vim.pack.add({ "https://github.com/nvim-tree/nvim-web-devicons" })
vim.pack.add({ "https://github.com/zbirenbaum/copilot.lua" })
vim.pack.add({ "https://github.com/fang2hou/blink-copilot" })
vim.pack.add({ "https://github.com/saghen/blink.cmp" })
local opts = {
  keymap = { preset = 'default', ['<CR>'] = { 'accept', 'fallback' } },
  appearance = { nerd_font_variant = 'mono' },
  completion = {
    menu = {
      border = 'single',
      draw = {
        columns = { { "kind_icon" }, { "label", gap = 1 } },
        components = {
          kind_icon = {
            ellipsis = false,
            text = function(ctx)
              local lspkind = require("lspkind"); local icon = ctx.kind_icon
              if ctx.source_name == "copilot" then icon = "" 
              elseif ctx.source_name == "Path" then local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label); if dev_icon then icon = dev_icon end
              else icon = lspkind.symbolic(ctx.kind, { mode = "symbol" }) end
              return " " .. (icon or " ") .. " "
            end,
            highlight = function(ctx)
              local hl = ctx.kind_hl
              if ctx.source_name == "copilot" then return "CmpItemKindCopilot" end
              if ctx.source_name == "Path" then local _, dev_hl = require("nvim-web-devicons").get_icon(ctx.label); if dev_hl then hl = dev_hl end end
              return hl
            end,
          },
          label = {
            text = function(ctx) local success, node = pcall(require("colorful-menu").blink_components_text, ctx); return success and node or ctx.label end,
            highlight = function(ctx) local success, hl = pcall(require("colorful-menu").blink_components_highlight, ctx); return success and hl or ctx.label_hl end,
          },
        },
      },
    },
    documentation = { window = { border = 'single' }, auto_show = true },
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer', 'copilot' },
    providers = { copilot = { name = "copilot", module = "blink-copilot", score_offset = 100, async = true, opts = { max_completions = 3 } } },
  },
  snippets = { preset = 'luasnip' },
}
opts.fuzzy = {
  prebuilt_binaries = {
    force_version = 'v1.10.1',
  },
}
require("blink.cmp").setup(opts)
require("luasnip.loaders.from_vscode").lazy_load()

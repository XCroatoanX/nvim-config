vim.pack.add({ "https://github.com/xzbdmw/colorful-menu.nvim" })
vim.pack.add({ "https://github.com/L3MON4D3/LuaSnip" })
vim.pack.add({ "https://github.com/rafamadriz/friendly-snippets" })
vim.pack.add({ "https://github.com/onsails/lspkind-nvim" })
vim.pack.add({ { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("*")} })
local opts = {
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  },
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
              if ctx.source_name == "Path" then local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label); if dev_icon then icon = dev_icon end
              else icon = lspkind.symbolic(ctx.kind, { mode = "symbol" }) end
              return " " .. (icon or " ") .. " "
            end,
            highlight = function(ctx)
              local hl = ctx.kind_hl
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
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  snippets = { preset = 'luasnip' },
}

if vim.snippet then
  opts.keymap['<C-l>'] = {
    function(cmp)
      if vim.snippet.active({ direction = 1 }) then
        vim.snippet.jump(1)
        return true
      end
      return cmp.select_and_accept()
    end,
    'fallback',
  }
  opts.keymap['<C-h>'] = {
    function()
      if vim.snippet.active({ direction = -1 }) then
        vim.snippet.jump(-1)
        return true
      end
      return false
    end,
    'fallback',
  }
end

require("blink.cmp").setup(opts)
require("luasnip.loaders.from_vscode").lazy_load()

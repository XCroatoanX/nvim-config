vim.pack.add({ 'https://github.com/saghen/blink.lib', 'https://github.com/saghen/blink.cmp' })
vim.pack.add({ 'https://github.com/xzbdmw/colorful-menu.nvim', 'https://github.com/onsails/lspkind.nvim', 'https://github.com/rafamadriz/friendly-snippets' })
vim.pack.add({ "https://github.com/folke/lazydev.nvim" })

require("lazydev").setup({
  library = {
    { path = "${3rd}/luv/library", words = { "vim%.uv" } },
  },
})

local cmp = require('blink.cmp')
cmp.build():pwait()

cmp.setup({
    
  keymap = {
    preset = 'default',
    ['<CR>'] = { 'accept', 'fallback' },
    ['<Tab>'] = { 'select_and_accept', 'snippet_forward', 'fallback' },
    ['<S-Tab>'] = { 'snippet_backward', 'fallback' },
  },

  completion = {
  list = { selection = { preselect = false, auto_insert = false } },
  menu = { border = 'single',
  draw = {
            columns = { { "kind_icon" }, { "label", gap = 1 } },
            components = {
                kind_icon = {
                    text = function(ctx)
                        local icon = ctx.kind_icon
                        if vim.tbl_contains({ "Path" }, ctx.source_name) then
                            local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                            if dev_icon then
                                icon = dev_icon
                            end
                        else
                            icon = require("lspkind").symbol_map[ctx.kind] or icon
                        end

                        return icon .. ctx.icon_gap
                    end,
                    highlight = function(ctx)
                        local hl = ctx.kind_hl
                        if vim.tbl_contains({ "Path" }, ctx.source_name) then
                            local _, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                            if dev_hl then
                                hl = dev_hl
                            end
                        end
                        return hl
                    end,
                },
                label = {
                    text = function(ctx)
                        return require("colorful-menu").blink_components_text(ctx)
                    end,
                    highlight = function(ctx)
                        return require("colorful-menu").blink_components_highlight(ctx)
                    end,
                },
            },
        },
  },
  documentation = { window = { border = 'single' }, auto_show = true, auto_show_delay_ms = 500, },
  },
  fuzzy = { implementation = "prefer_rust_with_warning" },
signature = {
    enabled = true,
    window = { border = 'single' } 
},

sources = {
    default = { 'lazydev', 'lsp', 'path', 'snippets', 'buffer' },
    providers = {
      lazydev = { name = "LazyDev", module = "lazydev.integrations.blink", score_offset = 100 },
    },
  },
  snippets = { preset = 'default' },
})

return {
  'saghen/blink.cmp',

  dependencies = {
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'onsails/lspkind-nvim',
    'nvim-tree/nvim-web-devicons',
    'zbirenbaum/copilot.lua',
  },
  version = '1.*',

  opts = {
    keymap = {
      preset = 'default',
      ['<CR>'] = { 'accept', 'fallback' },
    },

    appearance = {
      nerd_font_variant = 'mono'
    },

    completion = {
      menu = {
        border = 'single',
        direction_priority = function()
          local ctx = require('blink.cmp').get_context()
          local item = require('blink.cmp').get_selected_item()
          if ctx == nil or item == nil then return { 's', 'n' } end

          local item_text = item.textEdit ~= nil and item.textEdit.newText or item.insertText or item.label
          local is_multi_line = item_text:find('\n') ~= nil

          if is_multi_line or vim.g.blink_cmp_upwards_ctx_id == ctx.id then
            vim.g.blink_cmp_upwards_ctx_id = ctx.id
            return { 'n', 's' }
          end
          return { 's', 'n' }
        end,

        draw = {
          components = {
            kind_icon = {
              text = function(ctx)
                local icon = ctx.kind_icon
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local dev_icon, _ = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_icon then icon = dev_icon end
                else
                  icon = require("lspkind").symbolic(ctx.kind, { mode = "symbol" })
                end
                return icon .. ctx.icon_gap
              end,

              highlight = function(ctx)
                local hl = ctx.kind_hl
                if vim.tbl_contains({ "Path" }, ctx.source_name) then
                  local _, dev_hl = require("nvim-web-devicons").get_icon(ctx.label)
                  if dev_hl then hl = dev_hl end
                end
                return hl
              end,
            }
          }
        }
      },

      documentation = { window = { border = 'single' }, auto_show = true },
    },

    signature = { window = { border = 'single' }, enabled = true, auto_open = true },

    snippets = { preset = 'luasnip' },

    sources = {
      default = { 'lsp', 'path', 'snippets', 'buffer' }, },

    fuzzy = {
      sorts = { 'exact', 'score', 'sort_text' },
      implementation = "prefer_rust_with_warning"
    },
  },

  opts_extend = { "sources.default" },

  config = function(_, opts)
    require("blink.cmp").setup(opts)
    require("luasnip.loaders.from_vscode").lazy_load()

    -- Keep inline Copilot suggestions working
    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuOpen',
      callback = function()
        require("copilot.suggestion").dismiss()
        vim.b.copilot_suggestion_hidden = true
      end,
    })

    vim.api.nvim_create_autocmd('User', {
      pattern = 'BlinkCmpMenuClose',
      callback = function()
        vim.b.copilot_suggestion_hidden = false
      end,
    })
  end,
}

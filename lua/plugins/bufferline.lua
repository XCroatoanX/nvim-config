return {
  "akinsho/bufferline.nvim",
  version = "*",
  dependencies = "nvim-tree/nvim-web-devicons",
  config = function()
    local diagnostics_indicator = function(count, level, diagnostics_dict, context)
      local s = " "
      for e, n in pairs(diagnostics_dict) do
        local sym = (e == "error" and " ")
            or (e == "warning" and " ")
            or " "
        s = s .. n .. sym
      end
      return s
    end

    offsets = {
      {
        filetype = "neo-tree", -- matches the sidebar filetype
        text = "Explorer",     -- optional label shown in bufferline
        highlight = "Directory",
        text_align = "left",   -- 'center', 'right', or 'left'
      }
    }

    hover = {
      enabled = true,
      delay = 200,
      reveal = { "close" },
    }

    groups = {
      options = {
        toggle_hidden_on_enter = true,
      },
      items = {
        {
          name = "Tests",
          highlight = { underline = true, sp = "blue" },
          priority = 2,
          icon = " ",
          matcher = function(buf)
            local name = vim.api.nvim_buf_get_name(buf.id) -- get full path
            return name:match('%_test') or name:match('%_spec')
          end,
        },
        {
          name = "Docs",
          highlight = { undercurl = true, sp = "green" },
          auto_close = false,
          matcher = function(buf)
            local name = vim.api.nvim_buf_get_name(buf.id)
            return name:match('%.md') or name:match('%.txt')
          end,
          separator = {
            style = require('bufferline.groups').separator.tab
          },
        },
      },
    }

    require("bufferline").setup {
      options = {
        mode = "buffers",
        numbers = "ordinal",
        diagnostics = "nvim_lsp",
        diagnostics_indicator = diagnostics_indicator,
        show_buffer_close_icons = true,
        show_close_icon = true,
        separator_style = "slant",
        always_show_bufferline = true,
        right_mouse_command = "",
        hover = hover,
        groups = groups,
        offsets = offsets,
      },
    }
  end,
}

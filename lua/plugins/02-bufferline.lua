vim.pack.add({ "https://github.com/akinsho/bufferline.nvim" })

local diagnostics_indicator = function(count, level, diagnostics_dict, context)
    local s = " "
    for e, n in pairs(diagnostics_dict) do
        local sym = (e == "error" and " ") or (e == "warning" and " ") or " "
        s = s .. n .. sym
    end
    return s
end

require("bufferline").setup({
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
        hover = { enabled = true, reveal = { "close" } },
        offsets = {
            {
                filetype = "neo-tree",
                text = "Neo-tree",
                highlight = "Directory",
                text_align = "left",
                separator = true,
            },
        },
        groups = {
            options = {
                toggle_hidden_on_enter = true
            },
            items = {
                {
                    name = "Tests",
                    highlight = { underline = true, sp = "blue" },
                    priority = 2,
                    icon = " ",
                    matcher = function(buf)
                        return buf.path:match('_test') or buf.path:match('_spec')
                    end,
                },
                {
                    name = "Docs",
                    highlight = { undercurl = true, sp = "green" },
                    auto_close = false,
                    matcher = function(buf)
                        return buf.path:match('%.md$') or buf.path:match('%.txt$')
                    end,
                    separator = {
                        style = require('bufferline.groups').separator.tab
                    },
                }
            }
        }
    },
})

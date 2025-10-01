return{
    "akinsho/bufferline.nvim",
    version = "*",
    dependencies = "nvim-tree/nvim-web-devicons",
    config = function()
      require("bufferline").setup {
        options = {
          mode = "buffers",
          numbers = "ordinal",
          diagnostics = "nvim_lsp",
          show_buffer_close_icons = true,
          show_close_icon = true,
          separator_style = "slant",
          always_show_bufferline = true,
          right_mouse_command = "",
          hover = {
            enabled = true,
            delay = 200,
            reveal = { "close" },
          },
        },
      }
    end,
}
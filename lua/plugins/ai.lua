return {

  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    cmd = "Copilot",
    event = "InsertEnter",
    config = function()
      require("copilot").setup({
        suggestion = { enabled = false },
        panel = { enabled = false },
      })
    end,
  },

  -- OpenCode AI
{
    "nickjvandyke/opencode.nvim",
    version = "*",
    dependencies = {
      {
        "folke/snacks.nvim",
        priority = 1000,
        lazy = false,
        -- Force install by removing 'optional = true'
        opts = {
          input = {},
          picker = {
            actions = {
              opencode_send = function(...) return require("opencode").snacks_picker_send(...) end,
            },
            win = {
              input = {
                keys = { ["<a-a>"] = { "opencode_send", mode = { "n", "i" } } },
              },
            },
          },
        },
      },
    },
    config = function()
      -- THE "NICE" SETTINGS
      vim.g.opencode_opts = {
        lsp = { enabled = true }, -- AI-powered Hover and Code Actions
        server = {
          -- Uses Snacks Terminal for a better UI than the default Neovim terminal
          toggle = function()
            require('snacks.terminal').toggle('opencode --port 3923', {
              win = {
                position = 'right',
                width = 0.35,
                on_win = function(win)
                  require('opencode.terminal').setup(win.win)
                end,
              },
            })
          end,
        },
      }

      vim.o.autoread = true

      local map = vim.keymap.set
      
      -- TOGGLE (The main one you were looking for)
      -- Using <leader>oa (OpenCode Assistant)
      map({ "n", "t" }, "<leader>oa", function() require("opencode").toggle() end, { desc = "Toggle OpenCode" })

      -- ASK
      map({ "n", "x" }, "<leader>oq", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Quick Ask AI" })
      
      -- ACTIONS (The menu)
      map({ "n", "x" }, "<leader>ox", function() require("opencode").select() end, { desc = "AI Actions" })
      
      -- CONTEXT
      map("n", "ga", function() require("opencode").prompt("@this ") end, { desc = "Add to context" })
      
      -- Keep your math remaps if you like them
      map("n", "+", "<C-a>", { desc = "Increment", noremap = true })
      map("n", "-", "<C-x>", { desc = "Decrement", noremap = true })

      -- Auto-notify when AI finishes a long task
      vim.api.nvim_create_autocmd("User", {
        pattern = "OpencodeEvent:session.idle",
        callback = function()
          vim.notify("AI response complete", "info", { title = "OpenCode" })
        end,
      })
    end,
  },
}

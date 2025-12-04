return {
  -- GitHub Copilot
  {
    "zbirenbaum/copilot.lua",
    dependencies = {
      "copilotlsp-nvim/copilot-lsp", -- optional: NES functionality
    },
    cmd = "Copilot",                 -- lazy-load when :Copilot is used
    event = "InsertEnter",           -- lazy-load when entering insert mode
    config = function()
      require("copilot").setup({
        suggestion = {
          auto_trigger = true,
          keymap = {
            accept = "<Tab>",
            accept_word = false,
            accept_line = false,
            next = "<C-j>",
            prev = "<C-k>",
            dismiss = "<C-]>",
          },
        },                               -- enable ghost text
        panel = { auto_refresh = true }, -- enable the Copilot panel
        nes = { enabled = false, auto_trigger = true },
      })
    end,
  },

  -- OpenCode AI coding assistant
  {
    "NickvanDyke/opencode.nvim",
    dependencies = {
      -- Recommended for `ask()` and `select()`.
      -- Required for `snacks` provider.
      ---@module 'snacks' <- Loads `snacks.nvim` types for configuration intellisense.
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    config = function()
      ---@type opencode.Opts
      vim.g.opencode_opts = {
        -- Explicit port to avoid requiring `lsof` on Windows.
        -- Make sure your `opencode` process is started with the same port,
        -- for example: `opencode --port 3923`.
        port = 3923,

        -- Your configuration, if any  see `lua/opencode/config.lua`, or "goto definition".
      }

      -- Required for `opts.events.reload`.
      vim.o.autoread = true

      -- Recommended/example keymaps.
      vim.keymap.set({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end,
        { desc = "Ask opencode" })
      vim.keymap.set({ "n", "x" }, "<C-x>", function() require("opencode").select() end,
        { desc = "Execute opencode action" })
      vim.keymap.set({ "n", "x" }, "ga", function() require("opencode").prompt("@this") end, { desc = "Add to opencode" })
      vim.keymap.set({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
      vim.keymap.set("n", "<S-C-u>", function() require("opencode").command("session.half.page.up") end,
        { desc = "opencode half page up" })
      vim.keymap.set("n", "<S-C-d>", function() require("opencode").command("session.half.page.down") end,
        { desc = "opencode half page down" })
      -- You may want these if you stick with the opinionated "<C-a>" and "<C-x>" above  otherwise consider "<leader>o".
      vim.keymap.set('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
      vim.keymap.set('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
    end,
  },
}

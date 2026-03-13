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
    "NickvanDyke/opencode.nvim",
    dependencies = {
      { "folke/snacks.nvim", opts = { input = {}, picker = {}, terminal = {} } },
    },
    -- Use 'init' to set the global variable BEFORE the plugin loads
    init = function()
      vim.g.opencode_opts = {
        port = 3923,
      }
    end,
    config = function()
      -- Required for auto-reloading changes made by the AI
      vim.o.autoread = true

      local map = vim.keymap.set
      map({ "n", "x" }, "<C-a>", function() require("opencode").ask("@this: ", { submit = true }) end, { desc = "Ask opencode" })
      map({ "n", "x" }, "<C-x>", function() require("opencode").select() end, { desc = "Execute action" })
      map({ "n", "x" }, "ga", function() require("opencode").prompt("@this") end, { desc = "Add to context" })
      map({ "n", "t" }, "<C-.>", function() require("opencode").toggle() end, { desc = "Toggle opencode" })
      
      map('n', '+', '<C-a>', { desc = 'Increment', noremap = true })
      map('n', '-', '<C-x>', { desc = 'Decrement', noremap = true })
    end,
  },
}

return {
{
    "mfussenegger/nvim-dap",
    event = "VeryLazy",
    dependencies = {
        "rcarriga/nvim-dap-ui",
        "nvim-neotest/nvim-nio",
        "jay-babu/mason-nvim-dap.nvim",
        "theHamsta/nvim-dap-virtual-text",
    },
},


  -- DAP UI
  {
    "rcarriga/nvim-dap-ui",
    dependencies = { "mfussenegger/nvim-dap" },
    config = function()
      local dap, dapui = require("dap"), require("dapui")
      dapui.setup()

      -- Auto open/close DAP UI
      dap.listeners.after.event_initialized["dapui_config"] = function() dapui.open() end
      dap.listeners.before.event_terminated["dapui_config"] = function() dapui.close() end
      dap.listeners.before.event_exited["dapui_config"] = function() dapui.close() end
    end,
  },

  -- Mason for DAP
  {
    "jay-babu/mason-nvim-dap.nvim",
    dependencies = { "mfussenegger/nvim-dap", "williamboman/mason.nvim" , "nvim-neotest/nvim-nio"},
    config = function()
      local ok, mason_dap = pcall(require, "mason-nvim-dap")
      if ok then
        mason_dap.setup({
          ensure_installed = { "codelldb " },
          automatic_installation = true,
        })
      end
    end,
  },

  -- Mason core (UI + installer)
  {
    "williamboman/mason.nvim",
    config = true,
  },
}


-- plugins/dap.lua
-- Debug Adapter Protocol (DAP).

return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "DAP: Toggle breakpoint" },
      { "<leader>dc", function() require("dap").continue() end,          desc = "DAP: Continue" },
      { "<leader>do", function() require("dap").step_over() end,         desc = "DAP: Step over" },
      { "<leader>di", function() require("dap").step_into() end,         desc = "DAP: Step into" },
      { "<leader>du", function() require("dapui").toggle() end,          desc = "DAP: Toggle UI" },
    },
    dependencies = {
      "nvim-lua/plenary.nvim",
      "MunifTanjim/nui.nvim",
      "rcarriga/nvim-dap-ui",
      "nvim-neotest/nvim-nio",
      "theHamsta/nvim-dap-virtual-text",

      -- JS/TS debugging
      "mxsdev/nvim-dap-vscode-js",
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      dapui.setup()

      -- Auto-open UI when a debug session starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end


      dap.adapters.python = {
        type = "executable",
        command = vim.fn.stdpath("data") .. "/mason/bin/debugpy",
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Debug current file",
          program = "${file}",
          pythonPath = function()
            return "python"
          end,
        },
      }
    end,
  },
}

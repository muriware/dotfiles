-- plugins/dap.lua
-- Debug Adapter Protocol configuration

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      "nvim-lua/plenary.nvim", -- Required by some DAP plugins
      "MunifTanjim/nui.nvim", -- Required by nvim-dap-ui
      "rcarriga/nvim-dap-ui", -- UI for DAP
      "nvim-neotest/nvim-nio", -- Required by newer versions of nvim-dap-ui
      "theHamsta/nvim-dap-virtual-text", -- Shows variable values inline
      "mxsdev/nvim-dap-vscode-js", -- JavaScript/TypeScript adapter
    },
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "Toggle Breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "Continue",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "Step Over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "Step Into",
      },
      {
        "<leader>du",
        function()
          require("dap-ui").toggle()
        end,
        desc = "Toggle UI",
      },
    },
    config = function()
      local dap = require("dap")
      local dapui = require("dapui")

      -- Configure DAP UI
      dapui.setup()

      -- Set up automatic UI opening
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- Add language-specific configurations here
    end,
  },
}

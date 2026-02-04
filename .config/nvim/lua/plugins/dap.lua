-- plugins/dap.lua
-- Debug Adapter Protocol (DAP).

return {
  {
    "mfussenegger/nvim-dap",
    keys = {
      {
        "<leader>db",
        function()
          require("dap").toggle_breakpoint()
        end,
        desc = "DAP: Toggle breakpoint",
      },
      {
        "<leader>dc",
        function()
          require("dap").continue()
        end,
        desc = "DAP: Continue",
      },
      {
        "<leader>do",
        function()
          require("dap").step_over()
        end,
        desc = "DAP: Step over",
      },
      {
        "<leader>di",
        function()
          require("dap").step_into()
        end,
        desc = "DAP: Step into",
      },
      {
        "<leader>du",
        function()
          require("dapui").toggle()
        end,
        desc = "DAP: Toggle UI",
      },
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

      -- Automatically open the DAP UI when a session starts
      dap.listeners.after.event_initialized["dapui_config"] = function()
        dapui.open()
      end

      -- JavaScript / TypeScript debugging via vscode-js-debug
      require("dap-vscode-js").setup({
        adapters = { "pwa-node" },
      })

      dap.adapters["pwa-node"] = {
        type = "server",
        host = "localhost",
        port = "${port}",
        executable = {
          command = "node",
          args = {
            vim.fn.stdpath("data") .. "/mason/packages/js-debug-adapter/js-debug/src/dapDebugServer.js",
            "${port}",
          },
        },
      }

      -- Base Node / JS / TS configurations
      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "launch",
          name = "Launch file",
          program = "${file}",
          cwd = vim.fn.getcwd(),
        },
        {
          type = "pwa-node",
          request = "launch",
          name = "Vitest: current file",
          cwd = vim.fn.getcwd(),
          runtimeExecutable = "node",
          runtimeArgs = {
            "./node_modules/vitest/vitest.mjs",
            "run",
            "${file}",
            "--no-threads",
          },
          console = "integratedTerminal",
          sourceMaps = true,
          -- autoAttachChildProcesses = true,
        },
      }

      -- Reuse the same configs across related filetypes
      dap.configurations.typescriptreact = dap.configurations.typescript
      dap.configurations.javascript = dap.configurations.typescript
      dap.configurations.javascriptreact = dap.configurations.typescript
    end,
  },
}

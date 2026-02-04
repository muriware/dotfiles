-- plugins/neotest.lua
-- Test runner integration.

return {
  "nvim-neotest/neotest",
  event = "BufReadPost",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-neotest/nvim-nio",

    -- Adapters
    "marilari88/neotest-vitest",
    "nvim-neotest/neotest-jest",
  },
  config = function()
    local neotest = require("neotest")

    neotest.setup({
      adapters = {
        require("neotest-vitest"),
        require("neotest-jest")({
          jestCommand = "npm test --",
          cwd = function()
            return vim.fn.getcwd()
          end,
        }),
      },
    })

    vim.keymap.set("n", "<leader>tt", neotest.run.run, { desc = "Run nearest test" })
    vim.keymap.set("n", "<leader>tf", function()
      neotest.run.run(vim.fn.expand("%"))
    end, { desc = "Run file tests" })
    vim.keymap.set("n", "<leader>ts", neotest.summary.toggle, { desc = "Toggle test summary" })
    vim.keymap.set("n", "<leader>to", neotest.output.open, { desc = "Open test output" })
  end,
}

-- plugins/zenmode.lua
-- Distraction-free writing mode

return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  opts = {
    window = {
      width = 90,
    },
    on_open = function()
      vim.cmd("setlocal spell") -- Enable spell checking in zen mode
    end,
    on_close = function()
      vim.cmd("setlocal nospell")
    end,
  },
  keys = {
    { "<leader>sm", "<cmd>ZenMode<CR>", desc = "Zen Mode" },
  },
}

-- plugins/zenmode.lua
-- Distraction-free mode for reading, writing, and focused thinking.

return {
  "folke/zen-mode.nvim",
  cmd = "ZenMode",
  keys = {
    { "<leader>sm", "<cmd>ZenMode<CR>", desc = "Zen Mode" },
  },
  opts = {
    window = {
      width = 95, -- wide enough for code + prose, narrow enough to reduce eye travel
    },
    on_open = function()
      vim.opt_local.spell = true
    end,
    on_close = function()
      vim.opt_local.spell = false
    end,
  },
}

-- plugins/gitsigns.lua
-- Git integration.

return {
  "lewis6991/gitsigns.nvim",
  event = "BufReadPre",
  opts = {
    current_line_blame = false,
    signs = {
      add = { text = "│" },
      change = { text = "│" },
      delete = { text = "_" },
      topdelete = { text = "‾" },
      changedelete = { text = "~" },
    },
  },
}

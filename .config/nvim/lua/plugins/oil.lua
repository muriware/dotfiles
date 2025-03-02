-- plugins/oil.lua
-- File explorer that uses the buffer interface

return {
  "stevearc/oil.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    view_options = {
      show_hidden = true,
      -- Hide special files/directories
      is_always_hidden = function(name)
        return name == ".."
      end,
    },
  },
  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil<CR>", desc = "Open oil file explorer" },
  },
}

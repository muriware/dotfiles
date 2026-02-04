-- plugins/oil.lua
-- File explorer as a normal buffer.

return {
  "stevearc/oil.nvim",
  cmd = "Oil",
  keys = {
    { "-", "<cmd>Oil<CR>", desc = "Open Oil file explorer" },
  },
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    view_options = {
      show_hidden = true,
      -- Hide parent entry; keeps navigation intentional
      is_always_hidden = function(name)
        return name == ".."
      end,
    },
  },
}

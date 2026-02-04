-- plugins/tmux-navigation.lua
-- Seamless navigation between tmux panes and Neovim splits.

return {
  "alexghergh/nvim-tmux-navigation",
  opts = {
    disable_when_zoomed = true, -- Avoid fighting tmux when a pane is zoomed
    keybindings = {
      left = "<C-h>",
      down = "<C-j>",
      up = "<C-k>",
      right = "<C-l>",
      last_active = "<C-\\>",
      next = "<C-Space>",
    },
  },
}

-- plugins/tmux-navigation.lua
-- Seamless navigation between tmux panes and neovim splits

return {
  "alexghergh/nvim-tmux-navigation",
  opts = {
    disable_when_zoomed = true, -- Don't navigate if the tmux pane is zoomed
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

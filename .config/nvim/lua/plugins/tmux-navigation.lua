return {
  'alexghergh/nvim-tmux-navigation',
  keys = { '<C-h>', '<C-j>', '<C-k>', '<C-l>', '<C-\\>', '<C-Space>' },
  config = function()
    local tmux_navigation = require("nvim-tmux-navigation")

    tmux_navigation.setup {
      disable_when_zoomed = true
    }

    vim.keymap.set('n', '<C-h>', tmux_navigation.NvimTmuxNavigateLeft)
    vim.keymap.set('n', '<C-j>', tmux_navigation.NvimTmuxNavigateDown)
    vim.keymap.set('n', '<C-k>', tmux_navigation.NvimTmuxNavigateUp)
    vim.keymap.set('n', '<C-l>', tmux_navigation.NvimTmuxNavigateRight)
    vim.keymap.set('n', '<C-\\>', tmux_navigation.NvimTmuxNavigateLastActive)
    vim.keymap.set('n', '<C-Space>', tmux_navigation.NvimTmuxNavigateNext)
  end
}

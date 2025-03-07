-- plugins/colorscheme.lua
-- Colorscheme configuration

return {
  "folke/tokyonight.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd([[colorscheme tokyonight-storm]])
  end,
}

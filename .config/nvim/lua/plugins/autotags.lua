-- plugins/autotag.lua
-- Automatic HTML/JSX/TSX tag closing and updating

return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {},
}

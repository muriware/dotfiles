-- plugins/autotag.lua
-- Automatic tag closing and renaming for HTML / JSX / TSX.

return {
  "windwp/nvim-ts-autotag",
  event = "InsertEnter",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {},
}

-- plugins/devicons.lua
-- File icons for Neovim plugins

return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  opts = {
    default = true,
    strict = true, -- Match only with exact match of file name
  },
}

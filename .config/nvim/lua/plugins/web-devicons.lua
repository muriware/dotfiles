-- plugins/devicons.lua
-- Filetype icons for UI plugins (statusline, file explorers, pickers).

return {
  "nvim-tree/nvim-web-devicons",
  lazy = true,
  opts = {
    default = true,
    strict = true, -- Only match exact filenames; avoids incorrect icon guesses
  },
}

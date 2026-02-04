-- plugins/autopairs.lua
-- Automatic bracket pairing.

return {
  "windwp/nvim-autopairs",
  event = "VeryLazy",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
  },
  opts = {
    check_ts = true,
    disable_filetype = {
      "TelescopePrompt",
      "vim",
      "oil",
    },
    enable_cmdline = true,
  },
}

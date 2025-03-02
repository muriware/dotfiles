-- plugins/autopairs.lua
-- Automatic bracket pairing

return {
  "windwp/nvim-autopairs",
  event = "InsertEnter",
  dependencies = { "nvim-treesitter/nvim-treesitter" },
  opts = {
    -- Disable in certain filetypes
    disable_filetype = { "TelescopePrompt", "vim" },

    -- Use treesitter for better pairing decisions
    check_ts = true,
  },
}

-- plugins/treesitter.lua
-- Syntax parsing and highlighting.

return {
  "nvim-treesitter/nvim-treesitter",
  main = "nvim-treesitter.configs",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "lua",
      "vim",
      "vimdoc",
      "python",
      "json",
      "yaml",
      "dockerfile",
      "bash",
      "markdown",
      "markdown_inline",
      "query",
      "gitignore",
    },
    auto_install = true,

    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },

    indent = {
      enable = true,
    },

    -- Incremental selection via syntax tree
    incremental_selection = {
      enable = true,
      keymaps = {
        init_selection = "<CR>",
        node_incremental = "<CR>",
        node_decremental = "<BS>",
        scope_incremental = "<TAB>",
      },
    },
  },
}

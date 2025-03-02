-- plugins/treesitter.lua
-- Syntax highlighting and code parsing

return {
  "nvim-treesitter/nvim-treesitter",
  main = "nvim-treesitter.configs",
  build = ":TSUpdate",
  event = { "BufReadPost", "BufNewFile" },
  opts = {
    ensure_installed = {
      "bash",
      "c",
      "commonlisp",
      "css",
      "dockerfile",
      "gitignore",
      "go",
      "html",
      "http",
      "javascript",
      "json",
      "lua",
      "make",
      "markdown",
      "markdown_inline", -- For better markdown support
      "python",
      "query",
      "rust",
      "scheme",
      "scss",
      "svelte",
      "tsx",
      "typescript",
      "vim",
      "vimdoc",
      "vue",
      "yaml",
    },
    auto_install = true,
    highlight = {
      enable = true,
      additional_vim_regex_highlighting = false,
    },
    indent = {
      enable = true,
    },
    -- Incremental selection based on syntax tree
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

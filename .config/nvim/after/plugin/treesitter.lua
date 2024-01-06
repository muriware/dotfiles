local status, treesitter = pcall(require, "nvim-treesitter.configs")
if (not status) then return end

treesitter.setup {
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
    "yaml"
  },
  auto_install = true,
  highlight = {
    enable = true
  }
}

-- plugins/conform.lua
-- Code formatting

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  opts = {
    formatters_by_ft = {
      css = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      javascript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      lua = { "stylua" },
      markdown = { "prettierd", "prettier" },
      python = { "isort", "black" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },
      -- Shell script formatting
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
    },
    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
      async = false,
      -- Stop after the first formatter succeeds
      stop_after_first = true,
    },
    formatters = {
      shfmt = {
        prepend_args = { "-i", "2" },
      },
      stylua = {
        args = {
          "--search-parent-directories",
          "--stdin-filepath",
          "$FILENAME",
          "-",
        },
      },
    },
  },
  cmd = "ConformInfo",
  keys = {
    {
      "<leader>cl",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "",
      desc = "Format buffer",
    },
  },
  init = function()
    vim.o.formatexpr = 'v:lua.require"conform".formatexpr()'
  end,
}

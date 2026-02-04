-- plugins/conform.lua
-- Formatting.

return {
  "stevearc/conform.nvim",
  event = { "BufWritePre", "BufNewFile" },
  cmd = "ConformInfo",
  init = function()
    vim.o.formatexpr = 'v:lua.require"conform".formatexpr()'
  end,
  keys = {
    {
      "<leader>cf",
      function()
        require("conform").format({ async = true, lsp_format = "fallback" })
      end,
      mode = "n",
      desc = "Format buffer",
    },
  },
  opts = {
    formatters_by_ft = {
      javascript = { "prettierd", "prettier" },
      javascriptreact = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      css = { "prettierd", "prettier" },
      html = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      yaml = { "prettierd", "prettier" },
      markdown = { "prettierd", "prettier" },

      -- Tooling / scripts
      lua = { "stylua" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },
      python = { "isort", "black" },
    },

    format_on_save = {
      timeout_ms = 500,
      lsp_format = "fallback",
      async = false,
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
}

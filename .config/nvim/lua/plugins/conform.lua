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
      python = { "isort", "black" },
      lua = { "stylua" },
      yaml = { "prettierd", "prettier" },
      json = { "prettierd", "prettier" },
      sh = { "shfmt" },
      bash = { "shfmt" },
      zsh = { "shfmt" },

      -- Optional (kept for occasional work)
      markdown = { "prettierd", "prettier" },
      typescript = { "prettierd", "prettier" },
      typescriptreact = { "prettierd", "prettier" },
      javascript = { "prettierd", "prettier" },
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

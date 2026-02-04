-- util/lsp_native.lua
-- Shared LSP helpers.

local M = {}

-- Capabilities extended for nvim-cmp completion.
-- Wrapped in a function so it’s only required after cmp is loaded.
function M.capabilities()
  return require("cmp_nvim_lsp").default_capabilities()
end

-- Runs when an LSP client attaches to a buffer.
-- All LSP-related keymaps live here to avoid duplication and drift.
function M.on_attach(_, bufnr)
  local keymap = require("util").keymap
  local opts = { buffer = bufnr, noremap = true }

  -- Navigation
  keymap("n", "gd", vim.lsp.buf.definition, opts)
  keymap("n", "gD", vim.lsp.buf.declaration, opts)
  keymap("n", "gi", vim.lsp.buf.implementation, opts)
  keymap("n", "gr", vim.lsp.buf.references, opts)
  keymap("n", "gt", vim.lsp.buf.type_definition, opts)

  -- Documentation
  keymap("n", "K", vim.lsp.buf.hover, opts)
  keymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)

  -- Workspace / symbols
  keymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)

  -- Diagnostics
  keymap("n", "<leader>vd", vim.diagnostic.open_float, opts)
  keymap("n", "[d", vim.diagnostic.goto_prev, opts)
  keymap("n", "]d", vim.diagnostic.goto_next, opts)

  -- Code actions / refactors
  keymap("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  keymap("n", "<leader>vrr", vim.lsp.buf.references, opts)
  keymap("n", "<leader>vrn", vim.lsp.buf.rename, opts)

  -- Formatting (manual trigger; on-save handled by conform)
  keymap("n", "<leader>vf", function()
    vim.lsp.buf.format({ async = true })
  end, opts)
end

return M

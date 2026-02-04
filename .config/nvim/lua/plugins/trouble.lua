-- plugins/trouble.lua
-- Unified diagnostics, references, and symbol lists.

return {
  "folke/trouble.nvim",
  cmd = "Trouble",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>",                        desc = "Diagnostics (project)" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>",           desc = "Diagnostics (buffer)" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>",                desc = "Document symbols" },
    { "<leader>cS", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Workspace symbols" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>",                            desc = "Location list" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>",                             desc = "Quickfix list" },
    { "gR",         "<cmd>Trouble lsp_references<cr>",                            desc = "LSP references" },
    { "<leader>xD", "<cmd>Trouble lsp_definitions<cr>",                           desc = "LSP definitions" },
    { "<leader>xI", "<cmd>Trouble lsp_implementations<cr>",                       desc = "LSP implementations" },
    { "<leader>xt", "<cmd>Trouble lsp_type_definitions<cr>",                      desc = "LSP type definitions" },
  },
  opts = {},
}

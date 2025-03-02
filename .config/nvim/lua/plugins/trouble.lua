-- plugins/trouble.lua
-- Diagnostics, references, and list viewer

return {
  "folke/trouble.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  cmd = "Trouble",
  opts = {},
  keys = {
    { "<leader>xx", "<cmd>Trouble diagnostics toggle<cr>", desc = "Document Diagnostics" },
    { "<leader>xX", "<cmd>Trouble diagnostics toggle filter.buf=0<cr>", desc = "Buffer Diagnostics" },
    { "<leader>cs", "<cmd>Trouble symbols toggle focus=false<cr>", desc = "Document Symbols" },
    { "<leader>cS", "<cmd>Trouble lsp toggle focus=false win.position=right<cr>", desc = "Workspace Symbols" },
    { "<leader>xL", "<cmd>Trouble loclist toggle<cr>", desc = "Location List" },
    { "<leader>xQ", "<cmd>Trouble qflist toggle<cr>", desc = "Quickfix List" },
    { "gR", "<cmd>Trouble lsp_references<cr>", desc = "LSP References" },
    { "<leader>xD", "<cmd>Trouble lsp_definitions<cr>", desc = "LSP Definitions" },
    { "<leader>xI", "<cmd>Trouble lsp_implementations<cr>", desc = "LSP Implementations" },
    { "<leader>xt", "<cmd>Trouble lsp_type_definitions<cr>", desc = "LSP Type Definitions" },
  },
}

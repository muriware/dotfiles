local M = {}

function M.keymap(mode, lhs, rhs, opts)
  opts = opts or { noremap = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M

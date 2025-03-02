-- util/init.lua
-- Core utility functions for Neovim configuration

local M = {}

-- Define keymappings with sensible defaults
-- @param mode (string|table): Mode shortname or list of modes ("n", "i", "v", etc.)
-- @param lhs (string): Left-hand side of the mapping (the key to press)
-- @param rhs (string|function): Right-hand side of the mapping (the command to execute)
-- @param opts (table, optional): Options for the mapping (defaults to {noremap = true})
function M.keymap(mode, lhs, rhs, opts)
  opts = opts or { noremap = true }
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M

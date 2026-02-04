-- util/init.lua
-- Small, helper functions shared across the config.

local M = {}

-- Keymap helper with sensible defaults.
--
-- @param mode (string|table): mode(s), e.g. "n", "i", { "n", "v" }
-- @param lhs  (string): key sequence
-- @param rhs  (string|function): command or callback
-- @param opts (table|nil): keymap options (defaults to noremap = true)
function M.keymap(mode, lhs, rhs, opts)
  opts = opts or {}
  if opts.noremap == nil then
    opts.noremap = true
  end
  vim.keymap.set(mode, lhs, rhs, opts)
end

return M

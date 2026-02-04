-- config/autocmds.lua
-- Neovim autocommands configuration.

local augroup = vim.api.nvim_create_augroup

local cursorline_group = augroup("CursorLineOnlyActive", { clear = true })

-- Enable cursorline only in the active window.
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
  group = cursorline_group,
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      vim.opt_local.cursorline = true
    end
  end,
})

-- Disable cursorline when the window loses focus or while typing.
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
  group = cursorline_group,
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      vim.opt_local.cursorline = false
    end
  end,
})

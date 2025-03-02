-- config/autocmds.lua
-- Neovim autocommands configuration

-- Create autocmd group for window focus
local cursorline_group = vim.api.nvim_create_augroup("CursorLineOnlyActive", { clear = true })

-- Enable cursorline only for active window
vim.api.nvim_create_autocmd({ "WinEnter", "BufEnter", "InsertLeave" }, {
  group = cursorline_group,
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      vim.opt_local.cursorline = true
    end
  end,
})

-- Disable cursorline for inactive windows
vim.api.nvim_create_autocmd({ "WinLeave", "BufLeave", "InsertEnter" }, {
  group = cursorline_group,
  callback = function()
    if vim.bo.buftype ~= "terminal" then
      vim.opt_local.cursorline = false
    end
  end,
})

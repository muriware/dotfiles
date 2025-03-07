-- init.lua
-- Neovim initialization and plugin bootstrap

-- Bootstrap lazy.nvim if not already installed
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  print("Installing lazy.nvim...")
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
  print("lazy.nvim installed successfully!")
end

-- Add lazy.nvim to runtime path
vim.opt.rtp:prepend(lazypath)

-- Load core configuration
require("config")

-- Initialize plugins
require("lazy").setup("plugins", { defaults = { version = "*" } })

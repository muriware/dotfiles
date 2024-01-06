local status, colors = pcall(require, "rose-pine")
if (not status) then return end

colors.setup {
  variant = "moon"
}

vim.cmd("colorscheme rose-pine")

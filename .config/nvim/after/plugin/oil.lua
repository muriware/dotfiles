local status, oil = pcall(require, "oil")
if (not status) then return end

oil.setup {
  view_options = {
    show_hidden = true,
  }
}

vim.keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

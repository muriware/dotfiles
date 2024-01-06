local status, zen_mode = pcall(require, "zen-mode")
if (not status) then return end

local zen_mode_config = {
  window = {
    width = 90,
    options = {
      colorcolumn = ""
    }
  }
}

local function toggleZenMode()
  zen_mode.setup(zen_mode_config)
  zen_mode.toggle()
end

vim.keymap.set("n", "<leader>zz", toggleZenMode)

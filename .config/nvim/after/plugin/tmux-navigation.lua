local status, tmux_navigation = pcall(require, "nvim-tmux-navigation")
if (not status) then return end

tmux_navigation.setup {
  disable_when_zoomed = true
}

local function setKeymap(key, command)
  vim.keymap.set("n", key, command)
end

setKeymap("<C-h>", tmux_navigation.NvimTmuxNavigateLeft)
setKeymap("<C-j>", tmux_navigation.NvimTmuxNavigateDown)
setKeymap("<C-k>", tmux_navigation.NvimTmuxNavigateUp)
setKeymap("<C-l>", tmux_navigation.NvimTmuxNavigateRight)
setKeymap("<C-\\>", tmux_navigation.NvimTmuxNavigateLastActive)
setKeymap("<C-Space>", tmux_navigation.NvimTmuxNavigateNext)

local status, web_devicons = pcall(require, "nvim-web-devicons")
if (not status) then return end

web_devicons.setup {
  default = true
}

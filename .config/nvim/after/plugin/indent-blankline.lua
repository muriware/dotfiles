local status, ibl = pcall(require, "ibl")
if (not status) then return end

local rainbowColors = {
  RainbowRed = "#E06C75",
  RainbowYellow = "#E5C07B",
  RainbowBlue = "#61AFEF",
  RainbowOrange = "#D19A66",
  RainbowGreen = "#98C379",
  RainbowViolet = "#C678DD",
  RainbowCyan = "#56B6C2"
}

local hooks = require("ibl.hooks")

hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
  for colorName, hex in pairs(rainbowColors) do
    vim.api.nvim_set_hl(0, colorName, { fg = hex })
  end
end)

ibl.setup {
  indent = {
    char = "│",
    highlight = vim.tbl_keys(rainbowColors)
  },
  scope = {
    enabled = false
  }
}

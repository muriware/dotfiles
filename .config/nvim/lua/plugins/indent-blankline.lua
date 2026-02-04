-- plugins/indent-blankline.lua
-- Indentation guides.

return {
  "lukas-reineke/indent-blankline.nvim",
  event = "BufReadPre",
  config = function()
    -- Rainbow colors for indent levels (purely visual)
    local rainbow = {
      RainbowRed = "#E06C75",
      RainbowYellow = "#E5C07B",
      RainbowBlue = "#61AFEF",
      RainbowOrange = "#D19A66",
      RainbowGreen = "#98C379",
      RainbowViolet = "#C678DD",
      RainbowCyan = "#56B6C2",
    }

    local hooks = require("ibl.hooks")
    hooks.register(hooks.type.HIGHLIGHT_SETUP, function()
      for name, hex in pairs(rainbow) do
        vim.api.nvim_set_hl(0, name, { fg = hex })
      end
    end)

    require("ibl").setup({
      indent = {
        char = "│",
        highlight = vim.tbl_keys(rainbow),
      },
      scope = { enabled = false },
    })
  end,
}

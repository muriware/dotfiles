-- plugins/lualine.lua
-- Status line configuration

return {
  "nvim-lualine/lualine.nvim",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  event = "VimEnter",
  opts = {
    options = {
      icons_enabled = true,
      theme = "tokyonight",
      section_separators = { left = "", right = "" },
      component_separators = { left = "|", right = "|" },
      disabled_filetypes = {
        statusline = {},
        winbar = {},
      },
      globalstatus = true,
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = {
        { "branch", icon = "" },
      },
      lualine_c = {
        { "filename", file_status = true, path = 0 },
        { "diff", symbols = { added = " ", modified = " ", removed = " " } },
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
      },
      lualine_x = {
        {
          "filetype",
          icon = true,
          colored = false,
          padding = { left = 0, right = 1 },
        },
        "encoding",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },
    inactive_sections = {
      lualine_a = {},
      lualine_b = {},
      lualine_c = { { "filename", file_status = true, path = 1 } },
      lualine_x = { "location" },
      lualine_y = {},
      lualine_z = {},
    },
    extensions = {
      "quickfix",
    },
  },
}

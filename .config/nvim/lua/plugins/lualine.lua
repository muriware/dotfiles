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
    },
    sections = {
      lualine_a = { "mode" },
      lualine_b = { { "branch", icon = "" } },
      lualine_c = { { "filename", file_status = true, path = 0 } },
      lualine_x = {
        {
          "diagnostics",
          sources = { "nvim_diagnostic" },
          symbols = { error = " ", warn = " ", info = " ", hint = " " },
        },
        "encoding",
        "filetype",
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
  },
}

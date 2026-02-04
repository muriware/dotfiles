-- plugins/lualine.lua
-- Statusline.

return {
  "nvim-lualine/lualine.nvim",
  event = "VimEnter",
  dependencies = {
    "nvim-tree/nvim-web-devicons",
  },
  opts = {
    options = {
      theme = "tokyonight",
      icons_enabled = true,
      globalstatus = true,
      section_separators = { left = "", right = "" },
      component_separators = { left = "|", right = "|" },
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
        { "filetype", icon = true, colored = false },
        "encoding",
      },
      lualine_y = { "progress" },
      lualine_z = { "location" },
    },

    inactive_sections = {
      lualine_c = { { "filename", path = 1 } },
      lualine_x = { "location" },
    },

    extensions = { "quickfix" },
  },
}

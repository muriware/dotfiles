-- plugins/telescope.lua
-- Fuzzy finder and navigation hub.

local keymap = require("util").keymap

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  cmd = "Telescope",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  keys = {
    { "<leader>pf", desc = "Find files" },
    { "<C-p>",      desc = "Git files" },
    { "<leader>ps", desc = "Search string" },
    { "<leader>fg", desc = "Live grep" },
    { "<leader>fb", desc = "Buffers" },
    { "<leader>fr", desc = "Recent files" },
    { "<leader>vh", desc = "Help tags" },
    { "<leader>u",  desc = "Undo history" },
    { "<leader>gc", desc = "Git commits" },
    { "<leader>gC", desc = "Git buffer commits" },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
    })

    telescope.load_extension("undo")
    pcall(telescope.load_extension, "fzf")

    keymap("n", "<leader>pf", builtin.find_files)
    keymap("n", "<C-p>", builtin.git_files)
    keymap("n", "<leader>ps", function()
      local term = vim.fn.input("Grep > ")
      if term ~= "" then
        builtin.grep_string({ search = term })
      end
    end)
    keymap("n", "<leader>fg", builtin.live_grep)
    keymap("n", "<leader>fb", builtin.buffers)
    keymap("n", "<leader>fr", builtin.oldfiles)
    keymap("n", "<leader>vh", builtin.help_tags)
    keymap("n", "<leader>u", "<cmd>Telescope undo<CR>")
    keymap("n", "<leader>gc", builtin.git_commits)
    keymap("n", "<leader>gC", builtin.git_bcommits)
  end,
}

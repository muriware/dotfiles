-- plugins/telescope.lua
-- Fuzzy finder and picker

local keymap = require("util").keymap

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
  },
  cmd = "Telescope",
  keys = {
    { "<leader>pf", desc = "Find files" },
    { "<C-p>", desc = "Git files" },
    { "<leader>ps", desc = "Grep string" },
    { "<leader>vh", desc = "Help tags" },
    { "<leader>u", desc = "Undo history" },
    { "<leader>fb", desc = "Buffers" },
    { "<leader>fr", desc = "Recent files" },
    { "<leader>fg", desc = "Live grep" },
    { "<leader>gc", desc = "Git commits" },
    { "<leader>gC", desc = "Git buffer commits" },
  },
  config = function()
    local telescope = require("telescope")
    local builtin = require("telescope.builtin")

    -- Configure telescope
    telescope.setup({
      defaults = {
        prompt_prefix = " ",
        selection_caret = " ",
        -- path_display = { "truncate" },
        sorting_strategy = "ascending",
        layout_config = {
          horizontal = {
            prompt_position = "top",
            preview_width = 0.55,
          },
          vertical = {
            mirror = false,
          },
          width = 0.87,
          height = 0.80,
          preview_cutoff = 120,
        },
      },
    })

    -- Load extensions
    telescope.load_extension("undo")
    pcall(telescope.load_extension, "fzf")

    -- Define a nicer grep_string function with interrupt handling
    local grep_string = function()
      local search_term
      local ok = pcall(function()
        search_term = vim.fn.input("Grep > ")
      end)

      if not ok or search_term == "" then
        -- Input was canceled or empty
        return
      end

      builtin.grep_string({ search = search_term })
    end

    -- Set up keymaps
    keymap("n", "<leader>pf", builtin.find_files, {})
    keymap("n", "<C-p>", builtin.git_files, {})
    keymap("n", "<leader>ps", grep_string, {})
    keymap("n", "<leader>vh", builtin.help_tags, {})
    keymap("n", "<leader>u", "<cmd>Telescope undo<CR>")
    keymap("n", "<leader>fb", builtin.buffers, {})
    keymap("n", "<leader>fr", builtin.oldfiles, {})
    keymap("n", "<leader>fg", builtin.live_grep, {})
    keymap("n", "<leader>gc", builtin.git_commits, {})
    keymap("n", "<leader>gC", builtin.git_bcommits, {})
  end,
}

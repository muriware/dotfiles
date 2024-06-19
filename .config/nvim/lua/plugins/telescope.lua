local keymap = require("util").keymap

return {
  "nvim-telescope/telescope.nvim",
  branch = "0.1.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "debugloop/telescope-undo.nvim",
  },
  config = function()
    local builtin = require("telescope.builtin")

    local grep_string = function()
      builtin.grep_string({ search = vim.fn.input("Grep > ") })
    end

    keymap("n", "<leader>pf", builtin.find_files, {})
    keymap("n", "<C-p>", builtin.git_files, {})
    keymap("n", "<leader>ps", grep_string, {})
    keymap("n", "<leader>vh", builtin.help_tags, {})

    require("telescope").load_extension("undo")
    keymap("n", "<leader>u", "<cmd>Telescope undo<CR>")
  end,
}

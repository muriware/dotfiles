local status, builtin = pcall(require, "telescope.builtin")
if (not status) then return end

local function setKeymap(key, command)
  vim.keymap.set("n", key, command, { noremap = true, silent = true })
end

setKeymap("<leader>pf", builtin.find_files)
setKeymap("<C-p>", builtin.git_files)
setKeymap("<leader>ps", function()
  builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)
setKeymap("<leader>vh", builtin.help_tags)

local telescope = require("telescope")

telescope.setup {
  telescope.load_extension("undo"),
  vim.keymap.set("n", "<leader>u", "<cmd>Telescope undo<cr>")
}

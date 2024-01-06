vim.g.mapleader = " "

-- Adjust the position of a block of selected lines
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- Keep the cursor in its current position while joining consecutive lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep the cursor centered on the screen while scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Move to the next displayed line (helps with wrap)
vim.keymap.set('n', 'j', 'gj')
vim.keymap.set('n', 'k', 'gk')

-- Keep the cursor centered on the screen while navigating through search results
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without yanking text under the cursor or selection
vim.keymap.set("x", "<leader>p", [["_dP]])

-- Delete without yanking text under the cursor or selection
vim.keymap.set("n", "x", [["_x]])
vim.keymap.set({ "n", "v" }, "<leader>d", [["_d]])

-- Remap Escape key
vim.keymap.set("i", "jk", "<Esc>")

-- Format code using LSP
vim.keymap.set("n", "<leader>f", vim.lsp.buf.format)

-- Navigate through quickfix and location lists
vim.keymap.set("n", "<C-k>", "<cmd>cnext<CR>zz")
vim.keymap.set("n", "<C-j>", "<cmd>cprev<CR>zz")
vim.keymap.set("n", "<leader>k", "<cmd>lnext<CR>zz")
vim.keymap.set("n", "<leader>j", "<cmd>lprev<CR>zz")

-- Use word under the cursor as part of the search and replace pattern
vim.keymap.set("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Save the current file
vim.keymap.set("n", "<leader>w", [[:w<CR>]])

-- Toggle list mode
vim.keymap.set("n", "<leader>l", [[:set list!<CR>]])

-- Make the current file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })

-- Edit the Packer.nvim config file
vim.keymap.set("n", "<leader>vpp", "<cmd>e ~/src/dotfiles/.config/nvim/lua/muriware/packer.lua<CR>")

-- Run the 'make_it_rain' command
vim.keymap.set("n", "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>")

-- Source the current file
vim.keymap.set("n", "<leader><leader>", function()
  vim.cmd("so")
end)

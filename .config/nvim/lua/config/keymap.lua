local keymap = require("util").keymap

-- Adjust the position of a block of selected lines
keymap("v", "J", [[:m '>+1<CR>gv=gv]])
keymap("v", "K", [[:m '<-2<CR>gv=gv]])

-- Keep the cursor in its current position while joining consecutive lines
keymap("n", "J", "mzJ`z")

-- Keep the cursor centered on the screen while scrolling
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")

-- Move to the next displayed line (helps with wrap)
keymap("n", "j", "gj")
keymap("n", "k", "gk")

-- Keep the cursor centered on the screen while navigating through search results
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")

-- Clear search highlights
keymap("n", "<leader>nh", [[:nohl<CR>]])

-- Paste without yanking text under the cursor or selection
keymap("x", "<leader>p", [["_dP]])

-- Delete without yanking text under the cursor or selection
keymap("n", "x", [["_x]])
keymap({ "n", "v" }, "<leader>d", [["_d]])

-- Remap Escape key
keymap("i", "jk", "<Esc>")

-- Format code using LSP
keymap("n", "<leader>f", vim.lsp.buf.format)

-- Open current file in new splits
keymap("n", "<leader>av", [[:vsplit %<CR>]])
keymap("n", "<leader>as", [[:split %<CR>]])

-- Navigate through quickfix and location lists
keymap("n", "<C-k>", [[:cnext<CR>zz]])
keymap("n", "<C-j>", [[:cprev<CR>zz]])
keymap("n", "<leader>k", [[:lnext<CR>zz]])
keymap("n", "<leader>j", [[:lprev<CR>zz]])

-- Use word under the cursor as part of the search and replace pattern
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- Save the current file
keymap("n", "<leader>w", [[:w<CR>]])

-- Toggle list mode
keymap("n", "<leader>l", [[:set list!<CR>]])

-- Toggle spell checking
keymap("n", "<leader>vs", [[:setlocal spell!<CR>]])

-- Source the current file
keymap("n", "<leader><leader>", function()
  vim.cmd("so")
end)

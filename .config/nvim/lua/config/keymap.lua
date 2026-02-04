-- config/keymap.lua
-- Neovim key mappings and shortcuts.

local keymap = require("util").keymap

-- Movement and Positioning
-- Keep the cursor centered when scrolling or searching
keymap("n", "<C-d>", "<C-d>zz")
keymap("n", "<C-u>", "<C-u>zz")
keymap("n", "n", "nzzzv")
keymap("n", "N", "Nzzzv")
-- Move to the next displayed line (helps with wrapped lines)
keymap("n", "j", "gj")
keymap("n", "k", "gk")
-- Keep the cursor in place when joining lines
keymap("n", "J", "mzJ`z")
-- Adjust the position of selected text blocks
keymap("v", "J", [[:m '>+1<CR>gv=gv]])
keymap("v", "K", [[:m '<-2<CR>gv=gv]])

-- Editing Operations
-- Paste without yanking text under the cursor or selection
keymap("x", "<leader>p", [["_dP]])
-- Delete without yanking text
keymap("n", "x", [["_x]])
keymap({ "n", "v" }, "<leader>d", [["_d]])
-- Quick escape from insert mode
keymap("i", "jk", "<Esc>")
-- Format code using LSP
keymap("n", "<leader>f", vim.lsp.buf.format)
-- Search and replace word under cursor
keymap("n", "<leader>s", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]])

-- File and Window Management
-- Save the current file
keymap("n", "<leader>w", [[:w<CR>]])
-- Split window management
keymap("n", "<leader>av", [[:vsplit %<CR>]])
keymap("n", "<leader>as", [[:split %<CR>]])
-- Source the current file
keymap("n", "<leader><leader>", function()
  vim.cmd("so")
end)

-- Navigation and Lists
-- Navigate through quickfix and location lists
keymap("n", "<C-k>", [[:cnext<CR>zz]])
keymap("n", "<C-j>", [[:cprev<CR>zz]])
keymap("n", "<leader>k", [[:lnext<CR>zz]])
keymap("n", "<leader>j", [[:lprev<CR>zz]])

-- UI Toggles
-- Clear search highlights
keymap("n", "<leader>nh", [[:nohl<CR>]])
-- Toggle list mode (show invisible characters)
keymap("n", "<leader>l", [[:set list!<CR>]])
-- Toggle spell checking
keymap("n", "<leader>vs", [[:setlocal spell!<CR>]])
-- Show spelling suggestions for word under cursor
keymap("n", "<leader>z", "z=")

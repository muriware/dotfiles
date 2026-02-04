-- config/options.lua
-- Neovim core settings and options.

vim.g.mapleader = " "

local opt = vim.opt

-- UI settings
opt.background = "dark"
opt.cursorline = false   -- Highlight the current line
opt.laststatus = 3       -- Use global statusline
opt.number = true        -- Show line numbers
opt.pumheight = 10       -- Max popup menu height
opt.scrolloff = 8        -- Minimum lines above/below cursor
opt.showmode = false     -- Do not show mode, statusline displays it
opt.signcolumn = "yes"   -- Always show the sign column
opt.termguicolors = true -- Enable 24-bit RGB color in the terminal

-- Editor behavior
opt.clipboard = "unnamedplus" -- Use the system clipboard
opt.confirm = true            -- Confirm when unsaved changes exist
opt.timeoutlen = 500          -- Time in milliseconds to wait for mapped sequence
opt.updatetime = 50           -- Faster response time for CursorHold event

-- Indentation and whitespace
opt.breakindent = true                   -- Visually aligning wrapped lines
opt.expandtab = true                     -- Replace tabs with spaces
opt.listchars = "tab:>\\ ,eol:¬,trail:·" -- Display invisible characters
opt.shiftround = true                    -- Round indent to multiple of 'shiftwidth'
opt.shiftwidth = 2                       -- Number of spaces for each indent
opt.smartindent = true                   -- Auto-indent new lines
opt.softtabstop = 2                      -- Number of spaces for Tab key
opt.tabstop = 2                          -- Number of spaces tabs count for
opt.textwidth = 80                       -- Maximum width of text before wrapping
-- opt.colorcolumn = table.concat(vim.tbl_map(tostring, vim.fn.range(80, 999)), ',')

-- Search settings
opt.hlsearch = true      -- Highlight search results
opt.ignorecase = true    -- Case-insensitive searching
opt.inccommand = "split" -- Live preview of substitutions in split window
opt.incsearch = true     -- Incremental search that shows partial matches
opt.smartcase = true     -- Case-sensitive searching when capital letters used

-- Split behavior
opt.splitbelow = true -- Open horizontal splits below current window
opt.splitright = true -- Open vertical splits to the right of current window

-- File handling
opt.swapfile = false                               -- Do not use swap file for buffer
opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Directory for undo files
opt.undofile = true                                -- Enable persistent undo

-- Text formatting
opt.formatoptions = "tcroqnlj" -- Text formatting options
opt.spelllang = { "en_us" }    -- Language for spell checking

-- Message display
opt.shortmess:append({ W = true, I = true, c = true, C = true }) -- Reduce messages

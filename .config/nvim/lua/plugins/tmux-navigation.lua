return {
  "alexghergh/nvim-tmux-navigation",
  opts = {
    disable_when_zoomed = true,
  },
  keys = {
    { "<C-h>", "<cmd>NvimTmuxNavigateLeft<CR>" },
    { "<C-j>", "<cmd>NvimTmuxNavigateDown<CR>" },
    { "<C-k>", "<cmd>NvimTmuxNavigateUp<CR>" },
    { "<C-l>", "<cmd>NvimTmuxNavigateRight<CR>" },
    { "<C-\\>", "<cmd>NvimTmuxNavigateLastActive<CR>" },
    { "<C-Space>", "<cmd>NvimTmuxNavigateNext<CR>" },
  },
}

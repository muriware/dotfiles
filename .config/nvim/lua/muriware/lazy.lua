local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git",
    "clone",
    "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable", -- latest stable release
    lazypath,
  })
end

vim.opt.rtp:prepend(lazypath)

require("lazy").setup({
  -- Appearance and theme
  {
    "rose-pine/neovim",
    name = "rose-pine",
    lazy = false,
    priority = 1000
  },
  {
    "nvim-treesitter/nvim-treesitter",
    build = ":TSUpdate",
    event = "BufRead"
  },
  {
    "lukas-reineke/indent-blankline.nvim",
    event = "BufRead"
  },
  -- General modifiers
  {
    "nvim-lualine/lualine.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    event = "VimEnter"
  },
  {
    "alexghergh/nvim-tmux-navigation",
    keys = { "<C-h>", "<C-j>", "<C-k>", "<C-l>", "<C-\\>", "<C-Space>" }
  },
  {
    "folke/trouble.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { "<leader>xx", "<leader>xw", "<leader>xd", "<leader>xq", "<leader>xl" }
  },
  {
    "stevearc/dressing.nvim",
    event = "VimEnter"
  },
  {
    "folke/zen-mode.nvim",
    keys = { "<leader>zz" }
  },
  {
    "stevearc/oil.nvim",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    keys = { "-" }
  },
  {
    "eandrju/cellular-automaton.nvim",
    keys = { "<leader>mr" }
  },
  -- Fuzzy finder
  {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { "nvim-lua/plenary.nvim", "debugloop/telescope-undo.nvim" }
  },
  -- LSP setup
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x"
  },
  -- Lsp support
  {
    "williamboman/mason.nvim"
  },
  {
    "williamboman/mason-lspconfig.nvim"
  },
  {
    "neovim/nvim-lspconfig"
  },
  -- Lsp Autocompletion
  {
    "hrsh7th/cmp-nvim-lsp"
  },
  {
    "hrsh7th/cmp-buffer"
  },
  {
    "hrsh7th/cmp-path"
  },
  {
    "hrsh7th/cmp-cmdline"
  },
  {
    "hrsh7th/nvim-cmp"
  },
  -- Lsp Snippets
  {
    "L3MON4D3/LuaSnip",
    dependencies = { "rafamadriz/friendly-snippets" }
  },
  {
    "saadparwaiz1/cmp_luasnip"
  },
  -- Text editing and management
  {
    "windwp/nvim-autopairs",
    event = "InsertEnter"
  },
  {
    "windwp/nvim-ts-autotag",
    dependencies = { "nvim-treesitter/nvim-treesitter" },
    event = "InsertEnter"
  },
  {
    "kylechui/nvim-surround",
    event = "InsertEnter"
  },
  {
    "terrortylor/nvim-comment",
    keys = { "gc", "gcc" }
  },
  -- Git integration
  {
    "lewis6991/gitsigns.nvim",
    event = "BufRead"
  },
  {
    "dinhhuy258/git.nvim",
    event = "BufRead"
  }
})

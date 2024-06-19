local keymap = require("util").keymap

return {
  {
    "VonHeikemen/lsp-zero.nvim",
    branch = "v3.x",
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    "williamboman/mason.nvim",
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    event = "InsertEnter",
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_cmp()

      local cmp = require("cmp")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer", keyword_length = 3 },
          { name = "path", keyword_length = 2 },
          { name = "luasnip", keyword_length = 2 },
        },
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
          ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
          ["<C-y>"] = cmp.mapping.confirm({ select = true }),
          ["<C-Space>"] = cmp.mapping.complete(),
        }),
      })
    end,
  },

  -- LSP
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
      "williamboman/mason-lspconfig.nvim",
    },
    event = { "BufReadPre", "BufNewFile" },
    cmd = { "LspInfo", "LspInstall", "LspStart" },
    config = function()
      local lsp_zero = require("lsp-zero")
      lsp_zero.extend_lspconfig()

      lsp_zero.on_attach(function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true }

        keymap("n", "gd", function()
          vim.lsp.buf.definition()
        end, opts)
        keymap("n", "K", function()
          vim.lsp.buf.hover()
        end, opts)
        keymap("n", "<leader>vws", function()
          vim.lsp.buf.workspace_symbol()
        end, opts)
        keymap("n", "<leader>vd", function()
          vim.diagnostic.open_float()
        end, opts)
        keymap("n", "[d", function()
          vim.diagnostic.goto_next()
        end, opts)
        keymap("n", "]d", function()
          vim.diagnostic.goto_prev()
        end, opts)
        keymap("n", "<leader>vca", function()
          vim.lsp.buf.code_action()
        end, opts)
        keymap("n", "<leader>vrr", function()
          vim.lsp.buf.references()
        end, opts)
        keymap("n", "<leader>vrn", function()
          vim.lsp.buf.rename()
        end, opts)
        keymap("i", "<C-h>", function()
          vim.lsp.buf.signature_help()
        end, opts)
      end)

      require("mason-lspconfig").setup({
        ensure_installed = {
          "jsonls",
          "lua_ls",
          "tsserver",
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            -- (Optional) Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })

      vim.diagnostic.config({ virtual_text = true })
    end,
  },
}

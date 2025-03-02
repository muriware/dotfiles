-- plugins/lsp.lua
-- Language Server Protocol configuration

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
      "hrsh7th/cmp-nvim-lsp",
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
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body)
          end,
        },
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

      -- On attach function for LSP
      lsp_zero.on_attach(function(_, bufnr)
        local opts = { buffer = bufnr, noremap = true }

        -- Navigation
        keymap("n", "gd", function()
          vim.lsp.buf.definition()
        end, opts)
        keymap("n", "gD", function()
          vim.lsp.buf.declaration()
        end, opts)
        keymap("n", "gi", function()
          vim.lsp.buf.implementation()
        end, opts)
        keymap("n", "gr", function()
          vim.lsp.buf.references()
        end, opts)
        keymap("n", "gt", function()
          vim.lsp.buf.type_definition()
        end, opts)

        -- Documentation
        keymap("n", "K", function()
          vim.lsp.buf.hover()
        end, opts)
        keymap("i", "<C-h>", function()
          vim.lsp.buf.signature_help()
        end, opts)

        -- Workspace
        keymap("n", "<leader>vws", function()
          vim.lsp.buf.workspace_symbol()
        end, opts)

        -- Diagnostics
        keymap("n", "<leader>vd", function()
          vim.diagnostic.open_float()
        end, opts)
        keymap("n", "[d", function()
          vim.diagnostic.goto_prev()
        end, opts)
        keymap("n", "]d", function()
          vim.diagnostic.goto_next()
        end, opts)

        -- Actions
        keymap("n", "<leader>vca", function()
          vim.lsp.buf.code_action()
        end, opts)
        keymap("n", "<leader>vrr", function()
          vim.lsp.buf.references()
        end, opts)
        keymap("n", "<leader>vrn", function()
          vim.lsp.buf.rename()
        end, opts)
        keymap("n", "<leader>vf", function()
          vim.lsp.buf.format({ async = true })
        end, opts)
      end)

      -- Configure LSP servers
      require("mason-lspconfig").setup({
        ensure_installed = {
          "cssls",
          "eslint",
          "html",
          "jsonls",
          "lua_ls",
          "pyright",
          "tailwindcss",
          "ts_ls",
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            -- Configure lua language server for neovim
            local lua_opts = lsp_zero.nvim_lua_ls()
            require("lspconfig").lua_ls.setup(lua_opts)
          end,
        },
      })

      -- Diagnostic configuration
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
          border = "rounded",
          source = true,
        },
      })
    end,
  },
}

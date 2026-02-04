-- plugins/lsp.lua
-- LSP + completion.

return {
  {
    "williamboman/mason.nvim",
    lazy = false,
    -- Native LSP starts servers by executable name; make Mason-installed binaries discoverable.
    init = function()
      local mason_bin = vim.fn.stdpath("data") .. "/mason/bin"
      vim.env.PATH = mason_bin .. ":" .. vim.env.PATH
    end,
    config = true,
  },

  {
    "hrsh7th/nvim-cmp",
    event = "InsertEnter",
    dependencies = {
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-nvim-lsp",
      "L3MON4D3/LuaSnip",
      "rafamadriz/friendly-snippets",
      "saadparwaiz1/cmp_luasnip",
    },
    config = function()
      local cmp = require("cmp")
      local cmp_select = { behavior = cmp.SelectBehavior.Select }
      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        sources = {
          { name = "nvim_lsp" },
          { name = "buffer",  keyword_length = 3 },
          { name = "path",    keyword_length = 2 },
          { name = "luasnip", keyword_length = 2 },
        },
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

  {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",
    },
    config = function()
      local native = require("util.lsp_native")

      local function cfg(name, opts)
        opts = opts or {}
        opts.capabilities = native.capabilities()
        opts.on_attach = native.on_attach
        vim.lsp.config(name, opts)
        vim.lsp.enable(name)
      end

      -- Neovim runtime Lua
      cfg("lua_ls", {
        settings = {
          Lua = {
            diagnostics = { globals = { "vim" } },
            workspace = {
              library = vim.api.nvim_get_runtime_file("", true),
              checkThirdParty = false,
            },
            telemetry = { enable = false },
          },
        },
      })

      -- ML / Applied
      cfg("pyright")

      -- Platform / MLOps
      cfg("yamlls")
      cfg("bashls")
      cfg("dockerls")
      cfg("jsonls")

      -- TypeScript work
      cfg("ts_ls")
      cfg("eslint")

      -- Docs (README, specs, notes)
      cfg("marksman")

      -- Diagnostics UX
      vim.diagnostic.config({
        virtual_text = true,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = { border = "rounded", source = true },
      })
    end,
  },
}

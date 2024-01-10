return {
  {
    'VonHeikemen/lsp-zero.nvim',
    branch = 'v3.x',
    lazy = true,
    config = false,
    init = function()
      -- Disable automatic setup, we are doing it manually
      vim.g.lsp_zero_extend_cmp = 0
      vim.g.lsp_zero_extend_lspconfig = 0
    end,
  },
  {
    'williamboman/mason.nvim',
    lazy = false,
    config = true,
  },

  -- Autocompletion
  {
    'hrsh7th/nvim-cmp',
    event = 'InsertEnter',
    dependencies = {
      'hrsh7th/cmp-nvim-lsp',
      "hrsh7th/cmp-buffer",
      "hrsh7th/cmp-path",
      "hrsh7th/cmp-cmdline",
      'L3MON4D3/LuaSnip',
      'rafamadriz/friendly-snippets',
      'saadparwaiz1/cmp_luasnip'
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_cmp()

      local cmp = require('cmp')
      local cmp_select = { behavior = cmp.SelectBehavior.Select }

      require("luasnip.loaders.from_vscode").lazy_load()

      cmp.setup({
        sources = {
          { name = 'nvim_lsp' },
          { name = 'buffer',  keyword_length = 3 },
          { name = 'path',    keyword_length = 2 },
          { name = 'cmdline', keyword_length = 2 },
          { name = 'luasnip', keyword_length = 2 }
        },
        formatting = lsp_zero.cmp_format(),
        mapping = cmp.mapping.preset.insert({
          ['<C-p>'] = cmp.mapping.select_prev_item(cmp_select),
          ['<C-n>'] = cmp.mapping.select_next_item(cmp_select),
          ['<C-y>'] = cmp.mapping.confirm({ select = true }),
          ['<C-Space>'] = cmp.mapping.complete()
        })
      })
    end
  },

  -- LSP
  {
    'neovim/nvim-lspconfig',
    cmd = { 'LspInfo', 'LspInstall', 'LspStart' },
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'williamboman/mason-lspconfig.nvim'
    },
    config = function()
      local lsp_zero = require('lsp-zero')
      lsp_zero.extend_lspconfig()

      local function setKeymap(mode, key, action, opts)
        vim.keymap.set(mode, key, function() action() end, opts)
      end

      lsp_zero.on_attach(function(_, bufnr)
        local opts = { buffer = bufnr, remap = false }

        setKeymap('n', 'gd', vim.lsp.buf.definition, opts)
        setKeymap('n', 'K', vim.lsp.buf.hover, opts)
        setKeymap('n', '<leader>vws', vim.lsp.buf.workspace_symbol, opts)
        setKeymap('n', '<leader>vd', vim.diagnostic.open_float, opts)
        setKeymap('n', '[d', vim.diagnostic.goto_next, opts)
        setKeymap('n', ']d', vim.diagnostic.goto_prev, opts)
        setKeymap('n', '<leader>vca', vim.lsp.buf.code_action, opts)
        setKeymap('n', '<leader>vrr', vim.lsp.buf.references, opts)
        setKeymap('n', '<leader>vrn', vim.lsp.buf.rename, opts)
        setKeymap('i', '<C-h>', vim.lsp.buf.signature_help, opts)
      end)

      require('mason-lspconfig').setup({
        ensure_installed = {
          'jsonls',
          'lua_ls',
          'tsserver'
        },
        handlers = {
          lsp_zero.default_setup,
          lua_ls = function()
            local lua_opts = lsp_zero.nvim_lua_ls()
            require('lspconfig').lua_ls.setup(lua_opts)
          end,
        }
      })

      vim.diagnostic.config({ virtual_text = true })
    end
  }
}

local status, lsp = pcall(require, "lsp-zero")
if (not status) then return end

local function setKeymap(mode, key, action, opts)
  vim.keymap.set(mode, key, function() action() end, opts)
end

lsp.on_attach(function(client, bufnr)
  local opts = { buffer = bufnr, remap = false }

  setKeymap("n", "gd", vim.lsp.buf.definition, opts)
  setKeymap("n", "K", vim.lsp.buf.hover, opts)
  setKeymap("n", "<leader>vws", vim.lsp.buf.workspace_symbol, opts)
  setKeymap("n", "<leader>vd", vim.diagnostic.open_float, opts)
  setKeymap("n", "[d", vim.diagnostic.goto_next, opts)
  setKeymap("n", "]d", vim.diagnostic.goto_prev, opts)
  setKeymap("n", "<leader>vca", vim.lsp.buf.code_action, opts)
  setKeymap("n", "<leader>vrr", vim.lsp.buf.references, opts)
  setKeymap("n", "<leader>vrn", vim.lsp.buf.rename, opts)
  setKeymap("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end)

require("mason").setup {}
require("mason-lspconfig").setup {
  ensure_installed = {
    "jsonls",
    "lua_ls",
    "tsserver"
  },
  handlers = {
    lsp.default_setup,
    lua_ls = function()
      local lua_opts = lsp.nvim_lua_ls()
      require('lspconfig').lua_ls.setup(lua_opts)
    end
  }
}

local cmp = require("cmp")
local cmp_select = { behavior = cmp.SelectBehavior.Select }

require("luasnip.loaders.from_vscode").lazy_load()

cmp.setup({
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer", keyword_length = 3 },
    { name = "path", keyword_length = 2 },
    { name = "cmdline", keyword_length = 2},
    { name = "luasnip", keyword_length = 2 }
  },
  formatting = lsp.cmp_format(),
  mapping = {
    ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
    ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
    ["<C-y>"] = cmp.mapping.confirm({ select = true }),
    ["<C-Space>"] = cmp.mapping.complete()
  }
})

vim.diagnostic.config({ virtual_text = true })

return {
  'folke/zen-mode.nvim',
  keys = { '<leader>zz' },
  config = function()
    require('zen-mode').setup {
      window = {
        width = 80,
        options = {
          colorcolumn = ''
        }
      }
    }

    vim.keymap.set('n', '<leader>zz', '<cmd>ZenMode<CR>')
  end
}

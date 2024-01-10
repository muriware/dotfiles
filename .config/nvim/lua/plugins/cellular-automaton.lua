return {
  'eandrju/cellular-automaton.nvim',
  keys = { '<leader>mr' },
  config = function()
    vim.keymap.set('n', '<leader>mr', '<cmd>CellularAutomaton make_it_rain<CR>')
  end
}
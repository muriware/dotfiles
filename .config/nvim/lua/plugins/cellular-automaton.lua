-- plugins/fun.lua
-- Fun animations and effects

return {
  "eandrju/cellular-automaton.nvim",
  keys = {
    { "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Make it rain" },
    { "<leader>ms", "<cmd>CellularAutomaton scramble<CR>", desc = "Scramble text" },
  },
}

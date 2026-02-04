-- plugins/cellular-automaton.lua
-- Fun, non-essential visual effects (kept intentionally for breaks / demos).

return {
  "eandrju/cellular-automaton.nvim",
  keys = {
    { "<leader>mr", "<cmd>CellularAutomaton make_it_rain<CR>", desc = "Cellular Automaton: Make it rain" },
    { "<leader>ms", "<cmd>CellularAutomaton scramble<CR>",     desc = "Cellular Automaton: Scramble text" },
  },
}

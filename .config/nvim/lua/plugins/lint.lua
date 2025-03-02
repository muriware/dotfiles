-- plugins/lint.lua
-- Code linting and diagnostics

return {
  "mfussenegger/nvim-lint",
  event = { "BufReadPost", "BufNewFile", "BufWritePre" },
  opts = {
    -- Events that trigger linting
    events = { "BufWritePost", "BufReadPost", "InsertLeave" },

    -- Linter configurations by filetype
    linters_by_ft = {
      css = { "stylelint" },
      javascript = { "eslint_d" },
      javascriptreact = { "eslint_d" },
      typescript = { "eslint_d" },
      typescriptreact = { "eslint_d" },
      python = { "flake8" },
      lua = { "luacheck" },
      sh = { "shellcheck" },
      bash = { "shellcheck" },
      zsh = { "shellcheck" },
      yaml = { "yamllint" },
      markdown = { "markdownlint" },
    },

    -- Configure specific linters
    linters = {
      eslint_d = {
        -- Only lint files in a project with eslint configured
        condition = function(ctx)
          return vim.fs.find({ ".eslintrc", ".eslintrc.js", ".eslintrc.json" }, { path = ctx.filename, upward = true })[1]
        end,
      },
      luacheck = {
        -- Ignore certain warnings for Neovim Lua
        args = {
          "--no-global", -- Don't report undefined globals
          "--no-unused", -- Don't report unused variables
          "--no-redefined", -- Don't report redefined variables
        },
      },
    },
  },
  config = function(_, opts)
    -- Create autocmd to trigger linting on specified events
    vim.api.nvim_create_autocmd(opts.events, {
      group = vim.api.nvim_create_augroup("nvim-lint", { clear = true }),
      callback = function()
        require("lint").try_lint()
      end,
    })

    -- Set up key mapping to manually trigger linting
    vim.keymap.set("n", "<leader>cl", function()
      require("lint").try_lint()
    end, { desc = "Trigger linting for current file" })
  end,
}

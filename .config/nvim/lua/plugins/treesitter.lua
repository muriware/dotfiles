return {
  'nvim-treesitter/nvim-treesitter',
  main = 'nvim-treesitter.configs',
  build = ':TSUpdate',
  event = 'BufRead',
  opts = {
    ensure_installed = {
      'bash',
      'c',
      'commonlisp',
      'css',
      'dockerfile',
      'gitignore',
      'go',
      'html',
      'http',
      'javascript',
      'json',
      'lua',
      'make',
      'markdown',
      'python',
      'query',
      'rust',
      'scheme',
      'scss',
      'svelte',
      'tsx',
      'typescript',
      'vim',
      'vimdoc',
      'vue',
      'yaml'
    },
    auto_install = true,
    highlight = {
      enable = true
    }
  }
}

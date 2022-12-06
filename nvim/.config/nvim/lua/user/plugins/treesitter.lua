require 'nvim-treesitter.configs'.setup {
  ensure_installed = {
    "bash",
    "css",
    "html",
    "javascript",
    "jsdoc",
    "json",
    "gitcommit",
    "lua",
    "make",
    "markdown",
    "tsx",
    "typescript",
    "yaml"
  },
  highlight = {
    enable = true
  },
  context_commentstring = {
    enable = true
  },
  sync_install = false,
  auto_install = true,
}

require 'treesitter-context'.setup()

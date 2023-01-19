require 'nvim-treesitter.configs'.setup {
  highlight = {
    enable = true
  },
  context_commentstring = {
    enable = true
  },
  sync_install = false,
  auto_install = false,
}

require 'treesitter-context'.setup()

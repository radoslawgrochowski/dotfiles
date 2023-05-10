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

vim.opt.foldexpr = "nvim_treesitter#foldexpr()"
vim.opt.foldlevel = 999
vim.opt.foldmethod = "expr"

require 'treesitter-context'.setup()

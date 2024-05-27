require('nvim-treesitter.configs').setup {
  autotag = {
    enable = true,
  },
  highlight = {
    enable = true,
  },
  context_commentstring = {
    enable = true,
  },
  sync_install = false,
  auto_install = false,
}

vim.opt.foldexpr = 'nvim_treesitter#foldexpr()'
vim.opt.foldlevel = 999
vim.opt.foldmethod = 'expr'

require('ts_context_commentstring').setup {}
vim.g.skip_ts_context_commentstring_module = true

require('treesitter-context').setup()

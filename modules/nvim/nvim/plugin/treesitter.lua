require('nvim-treesitter.configs').setup {
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

require('treesitter-context').setup {
  max_lines = 3,
}

require('nvim-ts-autotag').setup {}

vim.filetype.add { extension = { mdx = 'markdown.mdx' } }
vim.treesitter.language.register('markdown', 'markdown.mdx')

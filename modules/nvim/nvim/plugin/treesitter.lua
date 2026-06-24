require('nvim-treesitter').setup {}

vim.api.nvim_create_autocmd('FileType', {
  callback = function()
    pcall(vim.treesitter.start)
  end,
})

vim.opt.foldexpr = 'v:lua.vim.treesitter.foldexpr()'
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
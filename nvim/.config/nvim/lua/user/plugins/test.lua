local keymap = require 'lib.utils'.keymap

keymap('n', '<Leader>tn', ':TestNearest<CR>', { silent = false })
keymap('n', '<Leader>tf', ':TestFile<CR>', { silent = false })
keymap('n', '<Leader>ts', ':TestSuite<CR>', { silent = false })
keymap('n', '<Leader>tl', ':TestLast<CR>', { silent = false })
keymap('n', '<Leader>tv', ':TestVisit<CR>', { silent = false })

vim.cmd([[
  let g:test#strategy = 'neovim'
  let g:test#neovim#start_normal = 1
]])


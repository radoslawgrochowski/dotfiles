vim.g.mapleader = ' '

local keymap = require 'lib.utils'.keymap

keymap('n', '<leader>', '<NOP>')
keymap('n', '<leader><F5>', '<cmd>so $MYVIMRC<cr>')

-- clipboard
keymap('v', '<leader>y', '"+y')
keymap('n', '<leader>Y', '"+yg_')
keymap('n', '<leader>y', '"+y')

keymap('v', '<leader>p', '"+p')
keymap('v', '<leader>P', '"+P')
keymap('n', '<leader>p', '"+p')
keymap('n', '<leader>P', '"+P')

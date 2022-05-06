vim.g.mapleader = ' '

local keymap = require 'lib.utils'.keymap

keymap('n', '<leader>', '<NOP>')
keymap('n', '<leader><F5>', '<cmd>so $MYVIMRC<cr>')


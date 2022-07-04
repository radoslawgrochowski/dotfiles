vim.g.mapleader = ' '

local keymap = require 'lib.utils'.keymap

-- system clipboard with leader key
keymap('v', '<leader>y', '"+y')
keymap('n', '<leader>Y', '"+yg_')
keymap('n', '<leader>y', '"+y')
keymap('v', '<leader>p', '"+p')
keymap('v', '<leader>P', '"+P')
keymap('n', '<leader>p', '"+p')
keymap('n', '<leader>P', '"+P')

-- reselect visual selection after indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- allow gf to open non-existent files
keymap('', 'gf', ':edit <cfile><CR>')

-- Maintain the cursor position when yanking a visual selection
-- http://ddrscott.github.io/blog/2016/yank-without-jank/
keymap('v', 'y', 'myy`hay')
keymap('v', 'Y', 'myY`y')

-- disable annoying command line thing
keymap('n', 'q:', ':q<CR>')

-- open with default program
keymap('n', '<leader>x', ':!xdg-open %<cr><cr>')

-- navigation
keymap('n', '<leader>h', '<C-W>h')
keymap('n', '<leader>j', '<C-W>j')
keymap('n', '<leader>k', '<C-W>k')
keymap('n', '<leader>l', '<C-W>l')
keymap('n', '<leader>o', '<C-W>o')


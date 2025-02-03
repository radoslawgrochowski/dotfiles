local wk = require 'which-key'

vim.o.exrc = true
vim.o.hidden = true
vim.o.ignorecase = true
vim.o.incsearch = true
vim.o.listchars = 'tab:▸ ,trail:·'
vim.o.backup = false
vim.o.hlsearch = false
vim.o.swapfile = false
vim.o.wrap = false
vim.o.number = true
vim.o.relativenumber = true
vim.o.scrolloff = 8
vim.o.signcolumn = 'yes:1'
vim.o.smartcase = true
vim.o.termguicolors = true

-- tabs
vim.o.tabstop = 2
vim.o.softtabstop = 2
vim.o.shiftwidth = 2
vim.o.expandtab = true
vim.o.smartindent = true

vim.o.clipboard = 'unnamedplus'

-- markdown folding
vim.g.markdown_folding = true
vim.cmd [[
  au FileType markdown setlocal foldlevel=99
]]

vim.g.mapleader = ' '
local function keymap(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(
    mode,
    lhs,
    rhs,
    vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true })
  )
end

-- FIXME: switch to which-key
-- delete without yanking
keymap('n', '<leader>D', '"_D')
keymap('n', '<leader>d', '"_d')
keymap('v', '<leader>D', '"_D')
keymap('v', '<leader>d', '"_d')

-- reselect visual selection after indenting
keymap('v', '<', '<gv')
keymap('v', '>', '>gv')

-- allow gF to open non-existent files in gf manner
keymap('', 'gF', ':edit %:p:h/<cfile><CR>')

-- match q: as :q
keymap('n', 'q:', ':q<CR>')

-- match :qw as :wq
keymap('c', 'qw', ':wq<CR>')

wk.add {
  { '<leader>h', '<C-W>h', desc = 'jump to left pane' },
  { '<leader>j', '<C-W>j', desc = 'jump to down pane' },
  { '<leader>k', '<C-W>k', desc = 'jump to upper pane' },
  { '<leader>l', '<C-W>l', desc = 'jump to right pane' },
  { '<leader>o', '<C-W>o', desc = 'delete other panes' },

  { '<leader>b', group = 'buffers' },
  { '<leader>bD', '<cmd>bdelete<cr>', desc = 'Delete current buffer (force)' },
  { '<leader>bd', '<cmd>bdelete<cr>', desc = 'Delete current buffer' },
  { '<leader>bb', '<cmd>e #<cr>', desc = 'Switch to other buffer' },
  { '<leader>bo', '<cmd>%bdelete|edit #|bdelete #<cr>', desc = 'Delete other buffers' },
  { '[b', '<cmd>bprevious<cr>', desc = 'Prev buffer' },
  { ']b', '<cmd>bnext<cr>', desc = 'Next buffer' },
}

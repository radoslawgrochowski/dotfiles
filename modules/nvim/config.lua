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

-- panes
wk.register({
  h = { '<C-W>h', 'jump to left pane' },
  j = { '<C-W>j', 'jump to down pane' },
  k = { '<C-W>k', 'jump to upper pane' },
  l = { '<C-W>l', 'jump to right pane' },
  o = { '<C-W>o', 'delete other panes' },
}, { prefix = '<leader>' })

-- buffers
wk.register {
  ['[b'] = { '<cmd>bprevious<cr>', 'Prev buffer' },
  [']b'] = { '<cmd>bnext<cr>', 'Next buffer' },
  ['<leader>bb'] = { '<cmd>e #<cr>', 'Switch to other buffer' },
  ['<leader>bo'] = { '<cmd>%bdelete|edit #|bdelete #<cr>', 'Delete other buffers' },
  ['<leader>bd'] = { '<cmd>bdelete<cr>', 'Delete current buffer' },
  ['<leader>bD'] = { '<cmd>:bd<cr>', 'Delete buffer and window' },
}

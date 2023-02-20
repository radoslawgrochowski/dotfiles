lua << EOF
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
vim.o.signcolumn = 'yes:2'
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
vim.cmd([[
  au FileType markdown setlocal foldlevel=99
]])

vim.g.mapleader = ' '
function keymap (mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(
    mode,
    lhs,
    rhs,
    vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true  })
  )
end

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
keymap('', 'gF', ':edit %:p:h/<cfile><CR>')

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
EOF

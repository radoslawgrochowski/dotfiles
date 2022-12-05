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

-- markdown folding
vim.g.markdown_folding = true
vim.cmd([[
  au FileType markdown setlocal foldlevel=99
]])

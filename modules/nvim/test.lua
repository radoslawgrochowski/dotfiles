vim.keymap.set('n', '<Leader>tn', ':TestNearest<CR>', { silent = false })
vim.keymap.set('n', '<Leader>tf', ':TestFile<CR>', { silent = false })
vim.keymap.set('n', '<Leader>ts', ':TestSuite<CR>', { silent = false })
vim.keymap.set('n', '<Leader>tl', ':TestLast<CR>', { silent = false })
vim.keymap.set('n', '<Leader>tv', ':TestVisit<CR>', { silent = false })
vim.keymap.set('n', '<Leader>twn', ':TestNearest<CR> --watch', { silent = false })
vim.keymap.set('n', '<Leader>twf', ':TestFile<CR> --watch', { silent = false })
vim.keymap.set('n', '<Leader>tws', ':TestSuite<CR> --watch', { silent = false })
vim.keymap.set('n', '<Leader>twl', ':TestLast<CR> --watch', { silent = false })
vim.keymap.set('n', '<Leader>twv', ':TestVisit<CR> --watch', { silent = false })

vim.cmd([[
  let g:test#strategy = 'neovim'
  let g:test#neovim#start_normal = 1
  let g:test#javascript#jest#options = {
    \ 'suite': '--maxWorkers=50%',
  \}
]])

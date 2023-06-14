local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup {
  defaults = {
    path_display = { truncate = 1 },
    prompt_prefix = '   ',
    selection_caret = '  ',
    sorting_strategy = 'ascending',
    file_ignore_patterns = {
      '.git/',
      'node_modules/.*',
      'secret.d/.*',
      '%.pem'
    },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      previewer = false,
      layout_config = { width = 80 },
    },
    oldfiles = {
      prompt_title = 'History',
    },
    lsp_references = {
      previewer = false,
    },
  }
}

function keymap(mode, lhs, rhs, opts)
  vim.api.nvim_set_keymap(
    mode,
    lhs,
    rhs,
    vim.tbl_extend('keep', opts or {}, { noremap = true, silent = true })
  )
end

keymap('n', '<leader>D', '<cmd>Telescope diagnostics<CR>')
keymap('n', '<leader>r', '<cmd>Telescope live_grep<CR>')
keymap('n', '<leader>b', '<cmd>Telescope buffers<CR>')
keymap('n', '<leader>e', '<cmd>Telescope oldfiles<CR>')
keymap('n', '<leader>f', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files<CR>')
keymap('n', '<leader>w', '<cmd>Telescope lsp_dynamic_workspace_symbols<CR>')
keymap('n', '<leader>/', '<cmd>Telescope projects<CR>')

keymap('n', '<leader>F', '<cmd>Telescope resume<CR>')

require('telescope').load_extension('projects')
require('telescope').load_extension('fzf')

local telescope = require 'telescope'
local actions = require 'telescope.actions'

telescope.setup {
  defaults = {
    path_display = { truncate = 1 },
    prompt_prefix = '   ',
    selection_caret = '  ',
    sorting_strategy = 'ascending',
    file_ignore_patterns = { '.git/' },
  },
  pickers = {
    find_files = {
      hidden = true,
    },
    buffers = {
      previewer = false,
      layout_config = {
        width = 80,
      },
    },
    oldfiles = {
      prompt_title = 'History',
    },
    lsp_references = {
      previewer = false,
    },
  },
  extensions = {
    fzf = {
      fuzzy = true, -- false will only do exact matching
      override_generic_sorter = true, -- override the generic sorter
      override_file_sorter = true, -- override the file sorter
      case_mode = 'smart_case', -- or "ignore_case" or "respect_case"
      -- the default case_mode is "smart_case"
    },
  },
}

local keymap = require 'lib.utils'.keymap

keymap('n', '<leader>f', '<cmd>Telescope find_files find_command=rg,--ignore,--hidden,--files prompt_prefix=🔍<cr>')
keymap('n', '<leader>b', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
keymap('n', '<leader>R', [[<cmd>lua require('telescope.builtin').live_grep()<cr>]])
keymap('n', '<leader>r', [[<cmd>lua require('telescope').extensions.live_grep_args.live_grep_raw()<CR>]])
keymap('n', '<leader>e', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
keymap('n', '<leader>D', [[<cmd>lua require('telescope.builtin').diagnostics()<CR>]])

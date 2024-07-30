local wk = require 'which-key'
local telescope = require 'telescope'
local builtin = require 'telescope.builtin'

local defaults = {
  path_display = { 'truncate' },
}

vim.o.timeoutlen = 200

telescope.load_extension 'fzf'
telescope.setup { defaults = defaults }

wk.register({
  ['<space>'] = {
    function()
      builtin.find_files(defaults)
    end,
    'Find Files (root)',
  },
  [','] = {
    function()
      builtin.buffers { sort_mru = true, sort_lastused = true }
    end,
    'Switch Buffers',
  },
  ['f'] = {
    ['f'] = { builtin.resume, 'Resume' },
    ['r'] = { builtin.oldfiles, 'Recent' },
    ['g'] = { builtin.live_grep, 'Grep (root)' },
    ['G'] = {
      function()
        builtin.live_grep { cwd = false }
      end,
      'Grep (cwd)',
    },
    ['<space>'] = { builtin.find_files, 'Files (root)' },
    ['k'] = { builtin.keymaps, 'Keymaps' },
    ['w'] = {
      function()
        builtin.grep_string { word_match = '-w' }
      end,
      'Current word',
    },
    ['W'] = {
      function()
        builtin.grep_string { word_match = '-w', cwd = false }
      end,
      'Current word (cwd)',
    },
    ['d'] = {
      function()
        builtin.diagnostics()
      end,
      'Diagnostics (root)',
    },
    desc = 'Find',
  },
}, { prefix = '<leader>' })

wk.register({
  ['w'] = {
    function()
      builtin.grep_string()
    end,
    'Current selection (root)',
  },
  ['W'] = {
    function()
      builtin.grep_string { cwd = false }
    end,
    'Current selection (cwd)',
  },
}, { mode = 'v', prefix = '<leader>f' })

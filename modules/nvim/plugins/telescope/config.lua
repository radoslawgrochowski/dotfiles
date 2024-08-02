local wk = require 'which-key'
local telescope = require 'telescope'
local builtin = require 'telescope.builtin'

local defaults = {
  path_display = { 'filename_first' },
}

vim.o.timeoutlen = 200

telescope.load_extension 'fzf'
telescope.setup { defaults = defaults }

-- keybinds initialy based on https://www.lazyvim.org/extras/editor/telescope
wk.register({
  [','] = {
    function() builtin.buffers { sort_mru = true, sort_lastused = true } end,
    'Switch Buffers',
  },
  ['/'] = { builtin.live_grep, 'Grep (root)' },
  [':'] = { builtin.command_history, 'Command history' },
  ['<space>'] = { builtin.find_files, 'Find Files (root)' },

  ['f'] = {
    desc = 'Files',
    ['f'] = { builtin.find_files, 'Find (root)' },
    ['F'] = { function() builtin.find_files { root = false } end, 'Find (cwd)' },
    ['g'] = { builtin.git_files, 'Find (git)' },
    ['r'] = { builtin.oldfiles, 'Recent' },
    ['R'] = { function() builtin.oldfiles { cwd = vim.uv.cwd() } end, 'Recent (cwd)' },
  },

  ['g'] = {
    desc = 'Git',
    ['c'] = { builtin.git_commits, 'Commits' },
    ['C'] = { builtin.git_bcommits, 'Commits for buffer' },
    ['b'] = { builtin.git_branches, 'Branches' },
    ['s'] = { builtin.git_stash, 'Stash' },
  },

  ['s'] = {
    desc = 'Search',
    ['c'] = {
      function() require('telescope.builtin').colorscheme { enable_preview = true } end,
      'Colorscheme',
    },
    ['d'] = { function() builtin.diagnostics { bufnr = 0 } end, 'Diagnostics (buffer)' },
    ['D'] = { builtin.diagnostics, 'Diagnostics (root)' },
    ['g'] = { builtin.live_grep, 'Grep (root)' },
    ['G'] = { function() builtin.live_grep { root = false } end, 'Grep (cwd)' },
    ['h'] = { builtin.help_tags, 'Search help tags word (cwd)' },
    ['k'] = { builtin.keymaps, 'Keymaps' },
    ['r'] = { builtin.resume, 'Resume' },
    ['s'] = { builtin.lsp_workspace_symbols, 'Symbols (workspace)' },
    ['S'] = { builtin.lsp_dynamic_workspace_symbols, 'Symbols (dynamic workspace)' },
    ['w'] = { function() builtin.grep_string { word_match = '-w' } end, 'Current word' },
    ['W'] = {
      function() builtin.grep_string { word_match = '-w', root = false } end,
      'Current word (cwd)',
    },
  },
}, { prefix = '<leader>' })

wk.register({
  ['s'] = {
    desc = 'Search',
    ['w'] = { function() builtin.grep_string() end, 'Current selection (root)' },
    ['W'] = { function() builtin.grep_string { root = false } end, 'Current selection (cwd)' },
  },
}, { mode = 'v', prefix = '<leader>' })

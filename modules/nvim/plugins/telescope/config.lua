local wk = require 'which-key'
local telescope = require 'telescope'
local builtin = require 'telescope.builtin'

local defaults = {
  path_display = { 'filename_first' },
  hidden = true,
}

vim.o.timeoutlen = 200

telescope.load_extension 'fzf'
telescope.setup { defaults = defaults }

wk.add {
  {
    '<leader>,',
    function() builtin.buffers { sort_mru = true, sort_lastused = true } end,
    desc = 'Switch Buffers',
  },
  {
    '<leader>/',
    builtin.live_grep,
    desc = 'Grep (root)',
  },
  {
    '<leader>:',
    builtin.command_history,
    desc = 'Command history',
  },
  {
    '<leader><space>',
    builtin.find_files,
    desc = 'Find Files (root)',
  },

  { '<leader>f', group = 'Files' },
  {
    '<leader>ff',
    builtin.find_files,
    desc = 'Find (root)',
  },
  {
    '<leader>fF',
    function() builtin.find_files { root = false } end,
    desc = 'Find (cwd)',
  },
  {
    '<leader>fg',
    builtin.git_files,
    desc = 'Find (git)',
  },
  {
    '<leader>fr',
    builtin.oldfiles,
    desc = 'Recent',
  },
  {
    '<leader>fR',
    function() builtin.oldfiles { cwd = vim.uv.cwd() } end,
    desc = 'Recent (cwd)',
  },

  { '<leader>g', group = 'Git' },
  {
    '<leader>gc',
    builtin.git_commits,
    desc = 'Commits',
  },
  {
    '<leader>gC',
    builtin.git_bcommits,
    desc = 'Commits for buffer',
  },
  { '<leader>gb', builtin.git_branches, desc = 'Branches' },
  { '<leader>gs', builtin.git_stash, desc = 'Stash' },

  { '<leader>s', group = 'Search' },
  {
    '<leader>sc',
    function() require('telescope.builtin').colorscheme { enable_preview = true } end,
    desc = 'Colorscheme',
  },
  {
    '<leader>sd',
    function() builtin.diagnostics { bufnr = 0 } end,
    desc = 'Diagnostics (buffer)',
  },
  {
    '<leader>sD',
    builtin.diagnostics,
    desc = 'Diagnostics (root)',
  },
  {
    '<leader>sg',
    builtin.live_grep,
    desc = 'Grep (root)',
  },
  {
    '<leader>sG',
    function() builtin.live_grep { root = false } end,
    desc = 'Grep (cwd)',
  },
  {
    '<leader>sh',
    builtin.help_tags,
    desc = 'Search help tags word (cwd)',
  },
  {
    '<leader>sk',
    builtin.keymaps,
    desc = 'Keymaps',
  },
  {
    '<leader>sr',
    builtin.resume,
    desc = 'Resume',
  },
  {
    '<leader>ss',
    builtin.lsp_workspace_symbols,
    desc = 'Symbols (workspace)',
  },
  {
    '<leader>sS',
    builtin.lsp_dynamic_workspace_symbols,
    desc = 'Symbols (dynamic workspace)',
  },
  {
    '<leader>sw',
    function() builtin.grep_string { word_match = '-w' } end,
    desc = 'Current word',
  },
  {
    '<leader>sW',
    function() builtin.grep_string { word_match = '-w', root = false } end,
    desc = 'Current word (cwd)',
  },
  {
    '<leader>sw',
    builtin.grep_string,
    desc = 'Current selection (root)',
    mode = 'v',
  },
  {
    '<leader>sW',
    function() builtin.grep_string { root = false } end,
    desc = 'Current selection (cwd)',
    mode = 'v',
  },
}

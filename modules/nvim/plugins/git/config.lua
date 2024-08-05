-- this is needed for `:GBrowse` to work
-- TODO: make this work on *nix
vim.api.nvim_create_user_command(
  'Browse',
  function(opts) vim.fn.system { 'open', opts.fargs[1] } end,
  { nargs = 1 }
)

local wk = require 'which-key'

local gitsigns = require 'gitsigns'

gitsigns.setup {
  -- not sure if I want this to enabled,
  -- might find it too distracting/useless
  -- current_line_blame = true,
}

wk.register({
  ['g'] = {
    desc = 'Git',
    ['g'] = { '<cmd>G<cr>', 'Status' },
    ['a'] = { '<cmd>G blame<cr>', 'Blame' },
    ['A'] = { '<cmd>G blame -C -C -C<cr>', 'Blame (deep)' },
    ['B'] = { '<cmd>GBrowse<cr>', 'Browse' },
    ['h'] = {
      ['s'] = { gitsigns.stage_hunk, 'Stage hunk' },
      ['r'] = { gitsigns.reset_hunk, 'Reset hunk' },
      ['S'] = { gitsigns.stage_buffer, 'Stage buffer' },
      ['u'] = { gitsigns.undo_stage_hunk, 'Undo stage hunk' },
      ['R'] = { gitsigns.reset_buffer, 'Reset buffer' },
      ['p'] = { gitsigns.preview_hunk, 'Preview hunk' },
      ['b'] = { function() gitsigns.blame_line { full = true } end, 'Blame line' },
      ['d'] = { gitsigns.diffthis, 'Diff this' },
      ['D'] = { function() gitsigns.diffthis '~' end, 'Diff this' },
    },
    ['t'] = {
      ['b'] = { gitsigns.toggle_current_line_blame, 'Toggle current line blame' },
      ['d'] = { gitsigns.toggle_deleted, 'Toggle deleted' },
    },
  },
}, { prefix = '<leader>' })

wk.register {
  [']c'] = {
    function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end,
    'Select next hunk',
  },
  ['[c'] = {
    function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end,
    'Select prev hunk',
  },
  ['ih'] = { ':<C-U>Gitsigns select_hunk<CR>', mode = { 'o', 'x' } },
}

wk.register({
  ['g'] = {
    ['h'] = {
      ['s'] = {
        function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
        'Stage hunk',
      },
      ['r'] = {
        function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
        'Reset hunk',
      },
    },
  },
}, { prefix = '<leader>', mode = 'v' })

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

wk.add {
  { '<leader>g', group = 'Git' },
  { '<leader>gg', '<cmd>G<cr>', desc = 'Status' },
  { '<leader>ga', '<cmd>G blame<cr>', desc = 'Blame' },
  { '<leader>gA', '<cmd>G blame -C -C -C<cr>', desc = 'Blame (deep)' },
  { '<leader>gB', '<cmd>GBrowse<cr>', desc = 'Browse' },

  { '<leader>gh', group = 'Hunks' },
  { '<leader>ghs', gitsigns.stage_hunk, desc = 'Stage hunk' },
  { '<leader>ghr', gitsigns.reset_hunk, desc = 'Reset hunk' },
  { '<leader>ghS', gitsigns.stage_buffer, desc = 'Stage buffer' },
  { '<leader>ghu', gitsigns.undo_stage_hunk, desc = 'Undo stage hunk' },
  { '<leader>ghR', gitsigns.reset_buffer, desc = 'Reset buffer' },
  { '<leader>ghp', gitsigns.preview_hunk, desc = 'Preview hunk' },
  { '<leader>ghb', function() gitsigns.blame_line { full = true } end, desc = 'Blame line' },
  { '<leader>ghd', gitsigns.diffthis, desc = 'Diff this' },
  { '<leader>ghD', function() gitsigns.diffthis '~' end, desc = 'Diff this' },
  {
    '<leader>gtb',
    gitsigns.toggle_current_line_blame,
    desc = 'Toggle current line blame',
  },
  { '<leader>gtd', gitsigns.toggle_deleted, desc = 'Toggle deleted' },
}

wk.add {
  {
    ']c',
    function()
      if vim.wo.diff then
        vim.cmd.normal { ']c', bang = true }
      else
        gitsigns.nav_hunk 'next'
      end
    end,
    desc = 'Select next hunk',
  },
  {
    '[c',
    function()
      if vim.wo.diff then
        vim.cmd.normal { '[c', bang = true }
      else
        gitsigns.nav_hunk 'prev'
      end
    end,
    desc = 'Select prev hunk',
  },
  { 'ih', ':<C-U>Gitsigns select_hunk<CR>', mode = { 'o', 'x' } },
}

wk.add {
  {
    '<leader>ghs',
    function() gitsigns.stage_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
    desc = 'Stage hunk',
    mode = 'v',
  },
  {
    '<leader>ghr',
    function() gitsigns.reset_hunk { vim.fn.line '.', vim.fn.line 'v' } end,
    desc = 'Reset hunk',
    mode = 'v',
  },
}

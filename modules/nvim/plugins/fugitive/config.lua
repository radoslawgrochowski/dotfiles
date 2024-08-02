-- this is needed for `:GBrowse` to work
-- TODO: make this work on *nix
vim.api.nvim_create_user_command(
  'Browse',
  function(opts) vim.fn.system { 'open', opts.fargs[1] } end,
  { nargs = 1 }
)

local wk = require 'which-key'

wk.register({
  ['g'] = {
    desc = 'Git',
    ['g'] = { '<cmd>G<cr>', 'Status' },
    ['a'] = { '<cmd>G blame<cr>', 'Blame' },
    ['A'] = { '<cmd>G blame -C -C -C<cr>', 'Blame (deep)' },
  },
}, { prefix = '<leader>' })

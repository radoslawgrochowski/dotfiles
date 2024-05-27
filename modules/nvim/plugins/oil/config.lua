local oil = require 'oil'
local wk = require 'which-key'

oil.setup {
  keymaps = {
    ['<BS>'] = 'actions.parent',
    ['q'] = 'actions.close',
    ['o'] = 'actions.open_external',
  },
}

wk.register {
  ['<leader>n'] = { '<cmd>Oil<cr>', 'Open oil' },
}

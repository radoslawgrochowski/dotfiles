local oil = require 'oil'
local wk = require 'which-key'

oil.setup {
  keymaps = {
    ['<BS>'] = 'actions.parent',
  },
}

wk.register {
  ['<leader>n'] = { '<cmd>Oil<cr>', 'Open oil' },
}

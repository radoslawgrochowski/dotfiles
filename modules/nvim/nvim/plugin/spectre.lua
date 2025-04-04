local spectre = require 'spectre'
local wk = require 'which-key'

spectre.setup()

wk.add {
  {
    '<leader>r',
    spectre.toggle,
    desc = 'Search and Replace',
  },
}

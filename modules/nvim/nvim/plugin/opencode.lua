local opencode = require 'opencode'
local snacks = require 'snacks'

local wk = require 'which-key'

wk.add {
  {
    '<leader>aa',
    function() opencode.ask '@this: ' end,
    desc = 'Ask opencode about this',
    mode = { 'n', 'v' },
  },
}

snacks.input.enable()

local opencode = require 'opencode'
local snacks = require 'snacks'

local wk = require 'which-key'

wk.add {
  {
    '<leader>aa',
    function() opencode.ask '@cursor: ' end,
    desc = 'Ask opencode',
    mode = 'n',
  },
  {
    '<leader>aa',
    function() opencode.ask '@selection: ' end,
    desc = 'Ask opencode about selection',
    mode = 'v',
  },
}

snacks.input.enable()

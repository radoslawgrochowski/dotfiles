local opencode = require 'opencode'

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

---@type opencode.Opts
vim.g.opencode_opts = {}

local opencode = require 'opencode'

local wk = require 'which-key'

wk.add {
  {
    '<leader>aa',
    function() opencode.ask '@this: ' end,
    desc = 'Ask opencode',
    mode = { 'n', 'v' },
  },
}

---@type opencode.Opts
vim.g.opencode_opts = {
  provider = {
    enabled = 'kitty',
    kitty = {
      location = 'tab',
    },
  },
}

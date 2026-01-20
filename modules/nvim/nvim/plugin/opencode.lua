local opencode = require 'opencode'

local wk = require 'which-key'

wk.add {
  {
    '<leader>ao',
    function() opencode.start() end,
    desc = 'Open opencode',
    mode = { 'n', 'v' },
  },
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
    cmd = 'opencode-fish --port',
    kitty = {
      location = 'tab',
    },
  },
}

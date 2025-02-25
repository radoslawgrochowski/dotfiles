local ai = require 'mini.ai'
local surround = require 'mini.surround'
local gen_ai_spec = require('mini.extra').gen_ai_spec

ai.setup {
  custom_textobjects = {
    f = ai.gen_spec.treesitter({ a = '@function.outer', i = '@function.inner' }, {}),
    g = gen_ai_spec.buffer(),
    i = gen_ai_spec.indent(),
    N = gen_ai_spec.number(),
    t = ai.gen_spec.treesitter({
      a = '@tag.outer',
      i = '@tag.inner',
    }, { search_method = 'nearest' }),
  },

  mappings = {
    around = 'a',
    inside = 'i',

    around_next = 'an',
    inside_next = 'in',
    around_last = 'al',
    inside_last = 'il',

    goto_left = 'g[',
    goto_right = 'g]',
  },
  n_lines = 500,
  search_method = 'cover_or_nearest',
  silent = false,
}

local ts_input = require('mini.surround').gen_spec.input.treesitter
surround.setup {
  n_lines = 500,
  custom_surroundings = {
    f = { input = ts_input { outer = '@function.outer', inner = '@function.inner' } },
    t = { input = ts_input { outer = '@tag.outer', inner = '@tag.inner' } },
  },
}

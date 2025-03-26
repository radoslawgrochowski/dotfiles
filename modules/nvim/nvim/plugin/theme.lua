local wk = require 'which-key'

vim.cmd.colorscheme 'tokyonight-night'

require('render-markdown').setup {
  latex = { enabled = false },
  file_types = { 'markdown', 'markdown.mdx' },
}
require('colorizer').setup {}
require('image').setup {}

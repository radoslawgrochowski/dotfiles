local wk = require 'which-key'

vim.cmd.colorscheme 'tokyonight-night'

require('render-markdown').setup {
  file_types = { 'markdown', 'markdown.mdx' },
}

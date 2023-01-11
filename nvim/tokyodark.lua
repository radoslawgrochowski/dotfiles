vim.cmd("colorscheme tokyonight-night")
require('lualine').setup {
  options = {
    theme = 'tokyonight'
  },
  sections = {
    lualine_y = {
      'progress',
      'lsp_progress',
    }
  }
}

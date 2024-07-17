local wk = require 'which-key'
local lspconfig = require 'lspconfig'
local lspformat = require 'lsp-format'
lspformat.setup {}

local capabilities = require('cmp_nvim_lsp').default_capabilities()

wk.register {
  ['gd'] = { vim.lsp.buf.definition, 'Go to definition' },
  ['gr'] = { vim.lsp.buf.references, 'Find references' },
  ['gi'] = { vim.lsp.buf.implementation, 'Go to implementation' },
  -- TODO: gy - Go to type definition
  ['gD'] = { vim.lsp.buf.declaration, 'Go to declaration' },
  ['g;'] = {
    function()
      vim.lsp.buf.format { async = false }
    end,
    'Format',
  },
  ['K'] = { vim.lsp.buf.hover, 'Hover help' },
  ['gK'] = { vim.lsp.buf.signature_help, 'Signature help' },
  ['gR'] = { vim.lsp.buf.rename, 'Rename' },

  ['<leader>ca'] = { vim.lsp.buf.code_action, 'Code actions' },

  ['[d'] = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
  [']d'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
  ['go'] = { vim.diagnostic.open_float, '' },
  ['gq'] = { vim.diagnostic.setloclist, 'Diagnostic quicklist' },
}

wk.register({
  ['ga'] = { vim.lsp.buf.code_action, 'Code actions' },
}, { mode = 'v' })

lspconfig.nil_ls.setup {
  capabilities,
  on_attach = lspformat.on_attach,
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
    },
  },
}

lspconfig.lua_ls.setup { capabilites, on_attach = lspformat.on_attach }
lspconfig.tsserver.setup { capabilites, on_attach = lspformat.on_attach }
lspconfig.efm.setup {
  capabilites,
  on_attach = lspformat.on_attach,
  init_options = { documentFormatting = true },
  settings = {
    rootMarkers = { '.git/' },
    languages = {
      lua = {
        require 'efmls-configs.formatters.stylua',
      },
    },
  },
}

require('fidget').setup {}

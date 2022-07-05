-- Mappings.
-- See `:help vim.diagnostic.*` for documentation on any of the below functions
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap('n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
vim.api.nvim_set_keymap('n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
vim.api.nvim_set_keymap('n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
---@diagnostic disable-next-line: unused-local
local on_attach = function(client, bufnr)
  -- Enable completion triggered by <c-x><c-o>
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  -- Mappings.
  -- See `:help vim.lsp.*` for documentation on any of the below functions
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>;', '<cmd>lua vim.lsp.buf.format{ async = true }<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', ':CodeActionMenu<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>cr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  -- vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>d', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'v', '<leader>ca', ':CodeActionMenu<CR>', opts)
end


vim.cmd [[autocmd! ColorScheme * highlight NormalFloat guibg=#1f2335]]
vim.cmd [[autocmd! ColorScheme * highlight FloatBorder guifg=white guibg=#1f2335]]

local border = {
  { "╭", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╮", "FloatBorder" },
  { "│", "FloatBorder" },
  { "╯", "FloatBorder" },
  { "─", "FloatBorder" },
  { "╰", "FloatBorder" },
  { "│", "FloatBorder" },
}

-- LSP settings (for overriding per client)
local handlers = {
  ["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, { border = border }),
  ["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, { border = border }),
}


-- Setup lspconfig.
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = {
  'tsserver',
  'ansiblels',
  'bashls',
  'eslint',
  'gopls',
}

for _, lsp in pairs(servers) do
  require('lspconfig')[lsp].setup {
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 50,
    },
    handlers = handlers,
    capabilities = capabilities,
  }
end

-- lua
local runtime_path = vim.split(package.path, ';')
table.insert(runtime_path, "lua/?.lua")
table.insert(runtime_path, "lua/?/init.lua")

local lspconfig = require 'lspconfig'

lspconfig.sumneko_lua.setup {
  on_attach = on_attach,
  flags = { debounce_text_changes = 50,
  },
  handlers = handlers,
  capabilities = capabilities,
  settings = {
    Lua = {
      runtime = {
        version = 'LuaJIT',
        path = runtime_path,
      },
      diagnostics = {
        globals = { 'vim' },
      },
      workspace = {
        library = vim.api.nvim_get_runtime_file("", true),
      },
      telemetry = {
        enable = false,
      },
    },
  },
}

local prettier = {
  formatCommand = [[$([ -n "$(command -v node_modules/.bin/prettier)" ] && echo "node_modules/.bin/prettier" || echo "prettier") --stdin-filepath ${INPUT} ${--config-precedence:configPrecedence} ${--tab-width:tabWidth} ${--single-quote:singleQuote} ${--trailing-comma:trailingComma}]],
  formatStdin = true,
}

lspconfig.efm.setup {
  capabilities = capabilities,
  handlers = handlers,
  on_attach = on_attach,
  cmd = { "/home/radoslawgrochowski/go/bin/efm-langserver" },
  init_options = { documentFormatting = true, codeAction = true },
  root_dir = vim.loop.cwd,
  settings = {
    rootMarkers = { ".git/" },
    lintDebounce = 100,
    -- logLevel = 5,
    languages = {
      typescript = { prettier },
      javascript = { prettier },
      typescriptreact = { prettier },
      javascriptreact = { prettier },
      yaml = { prettier },
      json = { prettier },
      html = { prettier },
      scss = { prettier },
      css = { prettier },
      markdown = { prettier },
    },
  },
  filetypes = {
    'markdown',
    'yaml',
    'json',
    'html',
    'css'
  }
}

capabilities.textDocument.completion.completionItem.snippetSupport = true

lspconfig.emmet_ls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = {
    'html',
    'typescriptreact',
    'javascriptreact',
    'css',
    'sass',
    'scss',
    'less',
  },
}


vim.cmd [[ autocmd BufWritePre *.tsx,*.ts,*.jsx,*.js EslintFixAll ]]
-- vim.cmd [[ autocmd BufWritePre * lua vim.lsp.buf.format{ async = true } ]]

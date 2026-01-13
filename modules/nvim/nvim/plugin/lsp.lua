local wk = require 'which-key'
local lspformat = require 'lsp-format'
lspformat.setup {}

-- suppress any inlayHint errors
local function safe_inlayhint_handler(err, result, ctx, config)
  if err then return nil end
  if vim.lsp.handlers['textDocument/inlayHint'] then
    return vim.lsp.handlers['textDocument/inlayHint'](err, result, ctx, config)
  end
  return nil
end

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

local capabilities =
    require('cmp_nvim_lsp').default_capabilities(vim.lsp.protocol.make_client_capabilities())

vim.lsp.inlay_hint.enable(true)

local lspFormat = function() vim.lsp.buf.format { async = false } end

wk.add {
  -- tries to match default keymaps from https://lsp-zero.netlify.app/v3.x/language-server-configuration.html#default-keybindings
  { 'K',  vim.lsp.buf.hover,           desc = 'Hover help' },
  { 'gd', vim.lsp.buf.definition,      desc = 'Go to definition' },
  { 'gD', vim.lsp.buf.declaration,     desc = 'Go to declaration' },
  { 'gi', vim.lsp.buf.implementation,  desc = 'Go to implementation' },
  { 'go', vim.lsp.buf.type_definition, desc = 'Go to type definition' },
  { 'gr', vim.lsp.buf.references,      desc = 'Find references' },
  { 'gs', vim.lsp.buf.signature_help,  desc = 'Signature help' },
  { 'gR', vim.lsp.buf.rename,          desc = 'Rename' },
  { 'g;', lspFormat,                   desc = 'Format' },
  { 'ga', vim.lsp.buf.code_action,     desc = 'Code actions' },
  { 'gl', vim.diagnostic.open_float,   desc = 'Show diagnostic in floating window' },
  { '[d', vim.diagnostic.goto_prev,    desc = 'Previous diagnostic' },
  { ']d', vim.diagnostic.goto_next,    desc = 'Next diagnostic' },
  { 'gq', vim.diagnostic.setloclist,   desc = 'Diagnostic quicklist' },

  {
    'ga',
    vim.lsp.buf.code_action,
    desc = 'Code actions',
    mode = 'v',
  },

  { '<leader>m',  group = 'LSP' },
  { '<leader>mr', '<cmd>LspRestart<cr>', desc = 'Restart' },
  { '<leader>mi', '<cmd>LspInfo<cr>',    desc = 'Info' },
  { '<leader>ml', '<cmd>LspLog<cr>',     desc = 'Log' },
}

vim.lsp.config('nil_ls', {
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixfmt' },
      },
    },
  },

  capabilities = capabilities,
  on_attach = lspformat.on_attach,
})
vim.lsp.enable 'nil_ls'

vim.lsp.config('lua_ls', {
  capabilities = capabilities,
  on_attach = lspformat.on_attach,
})
vim.lsp.enable 'lua_ls'

local vtslsSettings = {
  updateImportsOnFileMove = { enabled = 'always' },
  suggest = { completeFunctionCalls = true },
  inlayHints = {
    enumMemberValues = { enabled = false },
    functionLikeReturnTypes = { enabled = true },
    parameterNames = { enabled = 'literals' },
    parameterTypes = { enabled = false },
    propertyDeclarationTypes = { enabled = true },
    variableTypes = { enabled = false },
  },
}

local jsFiletypes = {
  'javascript',
  'javascriptreact',
  'javascript.jsx',
  'typescript',
  'typescriptreact',
  'typescript.tsx',
}

vim.lsp.config('vtsls', {
  filetypes = jsFiletypes,
  settings = {
    complete_function_calls = true,
    vtsls = {
      enableMoveToFileCodeAction = true,
      autoUseWorkspaceTsdk = true,
      experimental = {
        completion = {
          enableServerSideFuzzyMatch = true,
        },
      },
    },
    typescript = vtslsSettings,
    javascript = vtslsSettings,
  },

  handlers = {
    ['textDocument/inlayHint'] = safe_inlayhint_handler,
  },

  capabilities = capabilities,
  on_attach = function(client)
    client.commands['_typescript.moveToFileRefactoring'] = function(command)
      local action, uri, range = unpack(command.arguments)

      local function move(newf)
        client.request('workspace/executeCommand', {
          command = command.command,
          arguments = { action, uri, range, newf },
        })
      end

      local fname = vim.uri_to_fname(uri)
      client.request('workspace/executeCommand', {
        command = 'typescript.tsserverRequest',
        arguments = {
          'getMoveToRefactoringFileSuggestions',
          {
            file = fname,
            startLine = range.start.line + 1,
            startOffset = range.start.character + 1,
            endLine = range['end'].line + 1,
            endOffset = range['end'].character + 1,
          },
        },
      }, function(_, result)
        ---@type string[]
        local files = result.body.files
        table.insert(files, 1, 'Enter new path...')
        vim.ui.select(files, {
          prompt = 'Select move destination:',
          format_item = function(f) return vim.fn.fnamemodify(f, ':~:.') end,
        }, function(f)
          if f and f:find '^Enter new path' then
            vim.ui.input({
              prompt = 'Enter move destination:',
              default = vim.fn.fnamemodify(fname, ':h') .. '/',
              completion = 'file',
            }, function(newf) return newf and move(newf) end)
          elseif f then
            move(f)
          end
        end)
      end)
    end
  end,
})
vim.lsp.enable 'vtsls'

local base_on_attach = vim.lsp.config.eslint.on_attach
vim.lsp.config('eslint', {
  filetypes = jsFiletypes,
  capabilities = capabilities,
  on_attach = function(client, bufnr)
    if not base_on_attach then return end
    base_on_attach(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', { buffer = bufnr, command = 'LspEslintFixAll' })
  end,
})
vim.lsp.enable 'eslint'

local prettier = require 'efmls-configs.formatters.prettier'
local stylua = require 'efmls-configs.formatters.stylua'
local credo = {
  lintCommand = 'mix credo suggest --format=flycheck --read-from-stdin ${INPUT}',
  lintIgnoreExitCode = true,
  lintStdin = true,
  lintFormats = { '%f:%l:%c: %m' },
  rootMarkers = { 'mix.exs', 'mix.lock' },
}
local efmlanguages = {
  lua = { stylua },
  css = { prettier },
  html = { prettier },
  json = { prettier },
  markdown = { prettier },
  yaml = { prettier },
  elixir = { credo },
}
vim.lsp.config('efm', {
  capabilities = capabilities,
  on_attach = lspformat.on_attach,
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
  filetypes = vim.tbl_keys(efmlanguages),
  settings = {
    rootMarkers = { '.git/' },
    languages = efmlanguages,
  },
})
vim.lsp.enable 'efm'

local schemastore = require 'schemastore'
vim.lsp.config('jsonls', {
  capabilities = capabilities,
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
})
vim.lsp.enable 'jsonls'

vim.lsp.config('yamlls', {
  capabilities = capabilities,
  settings = {
    yaml = {
      schemaStore = { enable = false, url = '' },
      schemas = schemastore.json.schemas(),
    },
  },
})
vim.lsp.enable 'yamlls'

vim.lsp.config('bashls', {
  capabilities = capabilities,
})
vim.lsp.enable 'bashls'

vim.lsp.config('mdx_analyzer', {
  capabilities = capabilities,
  root_dir = require('lspconfig.util').root_pattern('.git', 'package.json'),
})
vim.lsp.enable 'mdx_analyzer'

vim.lsp.config('tailwindcss', {
  capabilities = capabilities,
})
vim.lsp.enable 'tailwindcss'

vim.lsp.config('astro', {
  capabilities = capabilities,
})
vim.lsp.enable 'astro'

vim.lsp.config('elixirls', {
  cmd = { vim.g.elixir_ls_path },
  capabilities = capabilities,
  on_attach = lspformat.on_attach,
})
vim.lsp.enable 'elixirls'

vim.lsp.config('rust_analyzer', {
  capabilities = capabilities,
  on_attach = lspformat.on_attach,
})
vim.lsp.enable 'rust_analyzer'

require('fidget').setup {}

local wk = require 'which-key'
local lspconfig = require 'lspconfig'
local lspformat = require 'lsp-format'
lspformat.setup {}

-- Reserve a space in the gutter
-- This will avoid an annoying layout shift in the screen
vim.opt.signcolumn = 'yes'

-- Add cmp_nvim_lsp capabilities settings to lspconfig
-- This should be executed before you configure any language server
local lspconfig_defaults = require('lspconfig').util.default_config
lspconfig_defaults.capabilities = vim.tbl_deep_extend(
  'force',
  lspconfig_defaults.capabilities,
  require('cmp_nvim_lsp').default_capabilities()
)

vim.lsp.inlay_hint.enable(true)

local lspFormat = function() vim.lsp.buf.format { async = false } end

wk.register {
  -- tries to match  efault keymaps from https://lsp-zero.netlify.app/v3.x/language-server-configuration.html#default-keybindings
  ['K'] = { vim.lsp.buf.hover, 'Hover help' },
  ['gd'] = { vim.lsp.buf.definition, 'Go to definition' },
  ['gD'] = { vim.lsp.buf.declaration, 'Go to declaration' },
  ['gi'] = { vim.lsp.buf.implementation, 'Go to implementation' },
  ['go'] = { vim.lsp.buf.type_definition, 'Go to type definition' },
  ['gr'] = { vim.lsp.buf.references, 'Find references' },
  ['gs'] = { vim.lsp.buf.signature_help, 'Signature help' },
  ['gR'] = { vim.lsp.buf.rename, 'Rename' },
  ['g;'] = { lspFormat, 'Format' },
  ['ga'] = { vim.lsp.buf.code_action, 'Code actions' },
  ['gl'] = { vim.diagnostic.open_float, 'Show diagnostic in floating window' },
  ['[d'] = { vim.diagnostic.goto_prev, 'Previous diagnostic' },
  [']d'] = { vim.diagnostic.goto_next, 'Next diagnostic' },
  ['gq'] = { vim.diagnostic.setloclist, 'Diagnostic quicklist' },
}

wk.register({
  desc = 'LSP',
  ['r'] = { '<cmd>LspRestart<cr>', 'Restart' },
  ['i'] = { '<cmd>LspInfo<cr>', 'Info' },
  ['l'] = { '<cmd>LspLog<cr>', 'Log' },
}, { prefix = '<leader>l' })

wk.register({
  ['ga'] = { vim.lsp.buf.code_action, 'Code actions' },
}, { mode = 'v' })

lspconfig.nil_ls.setup {
  settings = {
    ['nil'] = {
      formatting = {
        command = { 'nixpkgs-fmt' },
      },
    },
  },

  on_attach = lspformat.on_attach,
}

lspconfig.lua_ls.setup {
  on_attach = lspformat.on_attach,
}

local vtslsSettings = {
  updateImportsOnFileMove = { enabled = 'always' },
  suggest = { completeFunctionCalls = true },
  inlayHints = {
    enumMemberValues = { enabled = true },
    functionLikeReturnTypes = { enabled = true },
    parameterNames = { enabled = 'literals' },
    parameterTypes = { enabled = true },
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
  'astro',
}

lspconfig.vtsls.setup {
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
}

lspconfig.eslint.setup {
  filetypes = jsFiletypes,
  on_attach = function(client, bufnr)
    vim.api.nvim_create_autocmd('BufWritePre', {
      buffer = bufnr,
      command = 'EslintFixAll',
    })
  end,
}

lspconfig.efm.setup {
  on_attach = lspformat.on_attach,
  init_options = {
    documentFormatting = true,
    documentRangeFormatting = true,
  },
  filetypes = { 'lua', 'markdown' },
  settings = {
    rootMarkers = { '.git/' },
    languages = {
      lua = {
        require 'efmls-configs.formatters.stylua',
      },
      markdown = {
        require 'efmls-configs.formatters.prettier',
      },
    },
  },
}

lspconfig.ltex.setup {
  on_attach = function(client, bufnr)
    lspformat.on_attach(client, bufnr)
    require('ltex_extra').setup {}
  end,
  settings = { ltex = {} },
}

local schemastore = require 'schemastore'
lspconfig.jsonls.setup {
  settings = {
    json = {
      schemas = schemastore.json.schemas(),
      validate = { enable = true },
    },
  },
}
lspconfig.yamlls.setup {
  settings = {
    yaml = {
      schemaStore = {
        enable = false,
        url = '',
      },
      schemas = schemastore.json.schemas(),
    },
  },
}
lspconfig.bashls.setup {}
lspconfig.mdx_analyzer.setup {
  root_dir = require('lspconfig.util').root_pattern('.git', 'package.json'),
}
lspconfig.tailwindcss.setup {}
lspconfig.astro.setup {}
lspconfig.elixirls.setup {
  cmd = { ELIXIR_LS_PATH },
}

require('fidget').setup {}

local cmp = require 'cmp'
local types = require 'cmp.types'

cmp.setup {
  snippet = {
    expand = function(args) vim.snippet.expand(args.body) end,
  },
  performance = {
    debounce = 0,
    throttle = 0,
  },
  mapping = {
    ['<C-n>'] = {
      i = function()
        if cmp.visible() then
          cmp.select_next_item { behavior = types.cmp.SelectBehavior.Insert }
        else
          cmp.complete()
        end
      end,
    },
    ['<C-p>'] = {
      i = function()
        if cmp.visible() then
          cmp.select_prev_item { behavior = types.cmp.SelectBehavior.Insert }
        else
          cmp.complete()
        end
      end,
    },
    ['<C-Space>'] = { i = cmp.mapping.complete() },
    ['<C-e>'] = { i = cmp.mapping.abort() },
    ['<CR>'] = {
      i = cmp.mapping.confirm { select = true }, -- Accept currently selected item. Set `select` to `false` to only confirm explicitly selected items.
    },
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp', max_item_count = 5 },
    { name = 'nvim_lsp_signature_help', max_item_count = 5 },
  }, {
    { name = 'buffer', max_item_count = 3 },
    { name = 'path', max_item_count = 3 },
    { name = 'rg', keyword_length = 4, max_item_count = 3 },
  }),
  experimental = {
    ghost_text = {
      hl_group = 'CmpGhostText',
    },
  },
}

cmp.setup.cmdline({ '/', '?' }, {
  mapping = cmp.mapping.preset.cmdline(),
  sources = {
    { name = 'buffer' },
  },
})

cmp.setup.cmdline(':', {
  mapping = cmp.mapping.preset.cmdline(),
  sources = cmp.config.sources {
    { name = 'path' },
    { name = 'cmdline' },
  },
  matching = { disallow_symbol_nonprefix_matching = false },
})

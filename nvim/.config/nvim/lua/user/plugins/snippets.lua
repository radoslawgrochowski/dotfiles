local luasnip = require "luasnip"
luasnip.config.set_config {
  history = true,
  updateevents = "TextChanged,TextChangedI",
}

vim.keymap.set("i", "<C-n>", function() luasnip.jump(1) end)
vim.keymap.set("i", "<C-p>", function() luasnip.jump(-1) end)

luasnip.snippets = {}

local fmt = require("luasnip.extras.fmt").fmt
local snippet = luasnip.snippet
local i = luasnip.insert_node
local f = luasnip.function_node
local js = {
  snippet('log', fmt('console.log({})', { i(0) })),
  snippet('warn', fmt('console.warn({})', { i(0) })),
  snippet('debug', fmt('console.debug({})', { i(0) })),
  snippet('error', fmt('console.error({})', { i(0) })),
}

local ts = {
  snippet('tdi',
    fmt(
      [[
        describe('{1}', () => {{
          it('{2}', () => {{
            {3}
          }})
        }})
      ]],
      { i(1), i(2), i(3) })
  ),
}

local typescriptreact = {
  snippet('rce',
    fmt(
      [[
        import React from 'react'

        const {1} = () => {{
          {3}
        }}
        
        export default {2}
      ]],
      { i(1), f(function(args) return args[1] end, { 1 }), i(2) })
  ),
  snippet('rtl',
    fmt(
      [[
        import React from 'react'
        import {{ render, screen }} from '@testing-library/react'

        describe('{1}', () => {{
          it('renders', () => {{
            render({2})
            expect(screen.getBy{3}).toBeInTheDocument()
          }})
        }})
      ]],
      { i(1), f(function(args) return args[1] end, { 1 }), i(2) })
  ),
}

luasnip.add_snippets('javascript', js)
luasnip.add_snippets('javascriptreact', js)
luasnip.add_snippets('typescript', js)
luasnip.add_snippets('typescript', ts)
luasnip.add_snippets('typescriptreact', js)
luasnip.add_snippets('typescriptreact', ts)
luasnip.add_snippets('typescriptreact', typescriptreact)

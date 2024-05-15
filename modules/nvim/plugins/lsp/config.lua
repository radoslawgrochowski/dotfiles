local wk = require("which-key")
require('fidget').setup {}

-- TODO: come up with better mappings for those
wk.register({
	["gD"] = { vim.lsp.buf.declaration, "Go to declaration" },
	["gd"] = { vim.lsp.buf.definition, "Go to definition" },
	["gi"] = { vim.lsp.buf.implementation, "Go to implementation" },
	["gr"] = { vim.lsp.buf.references, "Find references" },
	["gh"] = { vim.lsp.buf.hover, "Hover help" },
	["gs"] = { vim.lsp.buf.signature_help, "Signature help" },
	["gR"] = { vim.lsp.buf.rename, "Rename" },
	["ga"] = { vim.lsp.buf.code_action, "Code actions" },

	["[d"] = { vim.diagnostic.goto_prev, "Previous diagnostic" },
	["]d"] = { vim.diagnostic.goto_next, "Next diagnostic" },
	["go"] = { vim.diagnostic.open_float, "" },
	["gq"] = { vim.diagnostic.setloclist, "Diagnostic quicklist" },
})

wk.register({
	["ga"] = { vim.lsp.buf.code_action, "Code actions" },
}, {mode="x"})

require'lspconfig'.nil_ls.setup{}

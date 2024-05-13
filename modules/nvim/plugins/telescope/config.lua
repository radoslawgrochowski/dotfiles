local wk = require("which-key")
local telescope = require("telescope")

telescope.load_extension("frecency")
telescope.load_extension("fzf")

wk.register({
	["<leader>"] = {
		["<space>"] = {
			function()
				telescope.extensions.frecency.frecency({
					workspace = "CWD",
				})
			end,
			"Find Files",
		},
	},
})

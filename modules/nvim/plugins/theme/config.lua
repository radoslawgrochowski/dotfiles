local wk = require('which-key');

vim.cmd.colorscheme "tokyonight-night"

wk.register({
  ["c"] = {
    function()
      require('telescope.builtin').colorscheme({ enable_preview = true })
    end,
    "Colorscheme",
  },
}, { prefix = "<leader>s", desc = "Settings" })

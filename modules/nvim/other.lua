local ts_alternative_targets = {
  { context = "source", target = "/%1/%2.%3" },
  { context = "source", target = "/%1/%2.%3" },
  { context = "test",   target = "/%1/%2.spec.%3" },
  { context = "test",   target = "/%1/%2.spec.%3" },
  { context = "test",   target = "/%1/%2.test.%3" },
  { context = "test",   target = "/%1/%2.test.%3" },
  { context = "stories",   target = "/%1/%2.stories.%3" },
  { context = "stories",   target = "/%1/%2.stories.%3" },
}

require("other-nvim").setup({
  mappings = {
    {
      pattern = "/(.*)/(.*)%.([jt]sx?)$",
      target = ts_alternative_targets
    },
    {
      pattern = "/(.*)/(.*)%.spec%.([jt]sx?)$",
      target = ts_alternative_targets
    },
    {
      pattern = "/(.*)/(.*)%.stories%.([jt]sx?)$",
      target = ts_alternative_targets
    }
  }
})


vim.api.nvim_set_keymap("n", "<leader>Q", "<cmd>:Other<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>qt", "<cmd>:Other test<CR>", { noremap = true, silent = true })
vim.api.nvim_set_keymap("n", "<leader>qs", "<cmd>:Other source<CR>", { noremap = true, silent = true })

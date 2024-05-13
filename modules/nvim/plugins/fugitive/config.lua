-- this is needed for `:GBrowse` to work
-- TODO: make this work on *nix
vim.api.nvim_create_user_command(
  'Browse',
  function (opts)
    vim.fn.system { 'open', opts.fargs[1] }
  end,
  { nargs = 1 }
)

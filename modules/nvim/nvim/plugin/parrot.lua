local api_key = os.getenv 'ANTHROPIC_API_KEY'
if not api_key then
  vim.notify('Parrot plugin not loaded: ANTHROPIC_API_KEY not found', vim.log.levels.INFO)
  -- Make parrot.setup a no-op function to prevent errors
  package.loaded['parrot'] = {
    setup = function() end,
  }
  return
end

require('parrot').setup {
  providers = {
    anthropic = {
      api_key = api_key,
    },
  },
}

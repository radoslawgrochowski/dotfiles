require('parrot').setup {
  providers = {
    gemini = {
      api_key = 'AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA',
    },
    openai = {
      api_key = os.getenv 'OPENAI_API_KEY',
    },
  },
}

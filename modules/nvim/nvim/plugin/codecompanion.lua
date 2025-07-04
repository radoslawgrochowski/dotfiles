local wk = require 'which-key'

require('codecompanion').setup {
  adapters = {
    vertex = function()
      return require('codecompanion.adapters').extend('gemini', {
        url = 'https://${location}-aiplatform.googleapis.com/v1/projects/${project_id}/locations/${location}/endpoints/openapi/chat/completions',
        env = {
          project_id = os.getenv 'GOOGLE_CLOUD_PROJECT',
          location = os.getenv 'GOOGLE_CLOUD_LOCATION',
          api_key = 'cmd: gcloud auth application-default print-access-token',
        },
        schema = {
          model = {
            default = 'google/gemini-2.5-flash',
          },
          choices = {
            ['google/gemini-2.5-pro'] = { opts = { can_reason = true, has_vision = true } },
            ['google/gemini-2.5-flash'] = { opts = { can_reason = true, has_vision = true } },
          },
        },
      })
    end,
    opts = {
      show_defaults = false,
    },
  },
  strategies = {
    chat = {
      adapter = 'vertex',
    },
    inline = {
      adapter = 'vertex',
    },
    cmd = {
      adapter = 'vertex',
    },
  },
}

wk.add {
  { '<leader>aa', '<cmd>CodeCompanion', desc = 'Prefill command' },
  { '<leader>a<space>', '<cmd>CodeCompanionActions<CR>', desc = 'Open Codecompanion Actions' },
  { '<leader>ac', '<cmd>CodeCompanionChat Toggle<CR>', desc = 'Toggle Codecompanion Chat' },
}

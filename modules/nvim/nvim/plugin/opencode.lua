local opencode = require 'opencode'

opencode.setup {
  prompts = {
    ---@class opencode.Prompt
    ---@field description? string Description of the prompt, show in selection menu.
    ---@field prompt? string The prompt to send to opencode, with placeholders for context like `@cursor`, `@buffer`, etc.
    explain = {
      description = 'Explain code near cursor',
      prompt = 'Explain @cursor and its context',
    },
    fix = {
      description = 'Fix diagnostics',
      prompt = 'Fix these @diagnostics',
    },
    optimize = {
      description = 'Optimize selection',
      prompt = 'Optimize @selection for performance and readability',
    },
    document = {
      description = 'Document selection',
      prompt = 'Add documentation comments for @selection',
    },
    test = {
      description = 'Add tests for selection',
      prompt = 'Add tests for @selection',
    },
    review_buffer = {
      description = 'Review buffer',
      prompt = 'Review @buffer for correctness and readability',
    },
    -- Add these after the next update:
    -- review_diff = {
    --   description = 'Review git diff',
    --   prompt = 'Review the following git diff for correctness and readability:\n@diff',
    -- },
    -- suggest_commit_msg = {
    --   description = 'Suggest commit message',
    --   prompt = 'Suggest commit message for following git diff:\n@diff',
    -- },
  },
}

local wk = require 'which-key'

wk.add {
  {
    '<leader>aa',
    function() opencode.ask '@cursor: ' end,
    desc = 'Ask opencode',
    mode = 'n',
  },
  {
    '<leader>aa',
    function() opencode.ask '@selection: ' end,
    desc = 'Ask opencode about selection',
    mode = 'v',
  },
  { '<leader>at', function() opencode.toggle() end, desc = 'Toggle embedded opencode' },
  {
    '<leader>an',
    function() opencode.command 'session_new' end,
    desc = 'New session',
  },
  {
    '<leader>ay',
    function() opencode.command 'messages_copy' end,
    desc = 'Copy last message',
  },
  {
    '<leader>ap',
    function() opencode.select_prompt() end,
    desc = 'Select prompt',
    mode = { 'n', 'v' },
  },
  -- Custom prompt example
  -- {
  --   '<leader>oe',
  --   function() opencode.prompt 'Explain @cursor and its context' end,
  --   desc = 'Explain code near cursor',
  -- },
}

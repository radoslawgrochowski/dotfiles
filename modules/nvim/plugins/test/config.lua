local wk = require 'which-key'
local neotest = require 'neotest'
local neotestJest = require 'neotest-jest'

-- TODO: recheck if this workaround is still needed
-- TODO: make it somehow compatibile with neotest-playwright
neotestJest.is_test_file = function(file_path)
  for _, x in ipairs { 'spec', 'test', 'unit' } do
    for _, ext in ipairs { 'js', 'jsx', 'ts', 'tsx' } do
      if string.match(file_path, '%.' .. x .. '%.' .. ext .. '$') then return true end
    end
  end
  return false
end

neotest.setup {
  adapters = {
    neotestJest {
      jestCommand = 'npm test -- --no-watch --no-watchAll',
      env = { IS_CI = true },
      cwd = function()
        local file = vim.fn.expand '%:p'
        if string.find(file, '/packages/') then return string.match(file, '(.-/[^/]+/)src') end
        return vim.fn.getcwd()
      end,
      jest_test_discovery = true,
    },
  },
  discovery = { enabled = false },
}

wk.register({
  ['t'] = {
    desc = 'Test',
    ['f'] = {
      function() neotest.run.run(vim.fn.expand '%') end,
      'Test file',
    },
    ['n'] = {
      function() neotest.run.run() end,
      'Test nearest',
    },
    ['s'] = {
      function() neotest.summary.toggle() end,
      'Toggle summary',
    },
    ['o'] = {
      function() neotest.output.open { enter = true, auto_close = true } end,
      'Show output',
    },
    ['O'] = {
      function() neotest.output_panel.toggle() end,
      'Toggle output panel',
    },
    ['S'] = {
      function() neotest.run.stop() end,
      'Stop nearest test',
    },
    ['a'] = {
      function() neotest.run.attach() end,
      'Attach to nearest test',
    },
    ['l'] = {
      function() neotest.run.run_last() end,
      'Re-run last test',
    },
    ['d'] = {
      function() neotest.run.run { strategy = 'dap' } end,
      'Debug nearest test',
    },
  },
}, { prefix = '<leader>' })

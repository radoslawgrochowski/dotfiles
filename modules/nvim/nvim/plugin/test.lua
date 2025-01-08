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

wk.add {
  { '<leader>t', group = 'Test' },
  {
    '<leader>tf',
    function() neotest.run.run(vim.fn.expand '%') end,
    desc = 'Test file',
  },
  {
    '<leader>tn',
    neotest.run.run,
    desc = 'Test nearest',
  },
  {
    '<leader>ts',
    neotest.summary.toggle,
    desc = 'Toggle summary',
  },
  {
    '<leader>to',
    function() neotest.output.open { enter = true, auto_close = true } end,
    desc = 'Show output',
  },
  {
    '<leader>tO',
    neotest.output_panel.toggle,
    desc = 'Toggle output panel',
  },
  {
    '<leader>tS',
    neotest.run.stop,
    desc = 'Stop nearest test',
  },
  {
    '<leader>ta',
    neotest.run.attach,
    desc = 'Attach to nearest test',
  },
  {
    '<leader>tl',
    neotest.run.run_last,
    desc = 'Re-run last test',
  },
  {
    '<leader>td',
    function() neotest.run.run { strategy = 'dap' } end,
    desc = 'Debug nearest test',
  },
}

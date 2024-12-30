local wk = require 'which-key'
local dap = require 'dap'
local dapui = require 'dapui'

dap.adapters['pwa-node'] = {
  type = 'server',
  host = 'localhost',
  port = '${port}',
  executable = {
    command = JS_DEBUG_PATH,
    args = {
      '${port}',
    },
  },
}

-- make node use pwa-node
if not dap.adapters['node'] then
  dap.adapters['node'] = function(cb, config)
    if config.type == 'node' then config.type = 'pwa-node' end
    local nativeAdapter = dap.adapters['pwa-node']
    if type(nativeAdapter) == 'function' then
      nativeAdapter(cb, config)
    else
      cb(nativeAdapter)
    end
  end
end

local js_filetypes = { 'typescript', 'javascript', 'typescriptreact', 'javascriptreact' }

local vscode = require 'dap.ext.vscode'
vscode.type_to_filetypes['node'] = js_filetypes
vscode.type_to_filetypes['pwa-node'] = js_filetypes

for _, language in ipairs(js_filetypes) do
  if not dap.configurations[language] then
    dap.configurations[language] = {
      {
        type = 'pwa-node',
        request = 'launch',
        name = 'Launch file',
        program = '${file}',
        cwd = '${workspaceFolder}',
      },
      {
        type = 'pwa-node',
        request = 'attach',
        name = 'Attach',
        processId = require('dap.utils').pick_process,
        cwd = '${workspaceFolder}',
      },
    }
  end
end

dapui.setup()

local widgets = require 'dap.ui.widgets'

wk.add {
  { '<leader>d', group = 'DAP' },
  {
    '<leader>db',
    function() dap.toggle_breakpoint() end,
    desc = 'Toggle breakpoint',
  },
  {
    '<leader>dc',
    function() dap.continue() end,
    desc = 'Continue',
  },
  {
    '<leader>dd',
    function() dapui.toggle() end,
    desc = 'Toggle full UI',
  },
  {
    '<leader>do',
    function() dap.step_over() end,
    desc = 'Step over',
  },
  {
    '<leader>di',
    function() dap.step_into() end,
    desc = 'Step into',
  },
  {
    '<leader>de',
    function() dapui.eval() end,
    desc = 'Evaluate expression (hover)',
  },
  {
    '<leader>ds',
    function()
      local scopesFloat = widgets.centered_float(widgets.scopes)
      scopesFloat.open()
    end,
    desc = 'Scopes',
  },
  {
    '<leader>df',
    function()
      local framesFloat = widgets.centered_float(widgets.frames)
      framesFloat.open()
    end,
    desc = 'Frames',
  },
  {
    '<leader>dr',
    dap.repl.toggle,
    desc = 'REPL',
  },
  {
    '<leader>dC',
    function() dapui.float_element 'console' end,
    desc = 'Console',
  },
  {
    '<leader>de',
    function() dapui.eval() end,
    desc = 'Evaluate expression (selected)',
    mode = 'v',
  },
}

-- TODO: Consider using something like https://github.com/theHamsta/nvim-dap-virtual-text

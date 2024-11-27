-- Hide gitignored files and show git tracked hidden files
-- https://github.com/stevearc/oil.nvim/blob/3c2de37accead0240fbe812f5ccdedfe0b973557/doc/recipes.md#hide-gitignored-files-and-show-git-tracked-hidden-files
local function parse_output(proc)
  local result = proc:wait()
  local ret = {}
  if result.code == 0 then
    for line in vim.gsplit(result.stdout, '\n', { plain = true, trimempty = true }) do
      -- Remove trailing slash
      line = line:gsub('/$', '')
      ret[line] = true
    end
  end
  return ret
end
local function new_git_status()
  return setmetatable({}, {
    __index = function(self, key)
      local ignore_proc = vim.system(
        { 'git', 'ls-files', '--ignored', '--exclude-standard', '--others', '--directory' },
        {
          cwd = key,
          text = true,
        }
      )
      local tracked_proc = vim.system({ 'git', 'ls-tree', 'HEAD', '--name-only' }, {
        cwd = key,
        text = true,
      })
      local ret = {
        ignored = parse_output(ignore_proc),
        tracked = parse_output(tracked_proc),
      }
      rawset(self, key, ret)
      return ret
    end,
  })
end
local git_status = new_git_status()
local refresh = require('oil.actions').refresh
local orig_refresh = refresh.callback
refresh.callback = function(...)
  git_status = new_git_status()
  orig_refresh(...)
end
local is_hidden_file = function(name, bufnr)
  local dir = require('oil').get_current_dir(bufnr)
  local is_dotfile = vim.startswith(name, '.') and name ~= '..'
  if not dir then return is_dotfile end
  if is_dotfile then
    return not git_status[dir].tracked[name]
  else
    return git_status[dir].ignored[name]
  end
end

local oil = require 'oil'
local wk = require 'which-key'

oil.setup {
  view_options = { is_hidden_file = is_hidden_file },
  keymaps = {
    ['<BS>'] = 'actions.parent',
    ['go'] = 'actions.open_external',
  },
}

wk.register {
  ['<leader>n'] = { '<cmd>Oil<cr>', 'Open oil' },
}

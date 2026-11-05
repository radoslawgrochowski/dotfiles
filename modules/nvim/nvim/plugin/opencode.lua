local opencode = require 'opencode'

local wk = require 'which-key'

local function tmux_exec(args)
  local cmd = { 'tmux' }
  vim.list_extend(cmd, args)

  local output = vim.fn.system(cmd)
  return vim.trim(output), vim.v.shell_error
end

local function get_tmux_session()
  if not vim.env.TMUX or not vim.env.TMUX_PANE then return end

  local session, code = tmux_exec {
    'display-message',
    '-p',
    '-t',
    vim.env.TMUX_PANE,
    '#{session_id}',
  }
  if code == 0 then return session end
end

local tmux_session = get_tmux_session()
-- Keep this port calculation in sync with opencode-wrapper in default.nix.
local opencode_port = tmux_session and (20000 + tonumber(tmux_session:match '^%$(%d+)$') % 20000)

local function start_tmux_server(continue_session)
  if not tmux_session then
    vim.notify(
      'Start Neovim inside tmux to open opencode.',
      vim.log.levels.ERROR,
      { title = 'opencode' }
    )
    return
  end

  -- A manually started OpenCode does not have a window recorded by this launcher.
  local connected, channel = pcall(vim.fn.sockconnect, 'tcp', '127.0.0.1:' .. opencode_port)
  if connected and channel > 0 then
    vim.fn.chanclose(channel)
    return
  end

  local opencode_window =
    tmux_exec { 'show-options', '-qv', '-t', tmux_session, '@opencode_window' }
  if opencode_window ~= '' then
    local dead, code = tmux_exec { 'display-message', '-p', '-t', opencode_window, '#{pane_dead}' }
    if code == 0 and dead == '0' then return end
  end

  local launch_cmd = {
    'new-window',
    '-d',
    '-P',
    '-F',
    '#{window_id}',
    '-t',
    tmux_session .. ':',
    '-n',
    'opencode',
    '-c',
    vim.fn.getcwd(),
    'opencode-wrapper',
    '--port',
    tostring(opencode_port),
  }

  if continue_session then table.insert(launch_cmd, '--continue') end

  local stdout, code = tmux_exec(launch_cmd)
  if code == 0 then
    tmux_exec { 'set-option', '-t', tmux_session, '@opencode_window', stdout }
    return
  end

  vim.notify(
    'Failed to start opencode in tmux:\n' .. stdout,
    vim.log.levels.ERROR,
    { title = 'opencode' }
  )
end

wk.add {
  {
    '<leader>ao',
    start_tmux_server,
    desc = 'Open opencode',
    mode = { 'n', 'v' },
  },
  {
    '<leader>aa',
    function() opencode.ask '@this: ' end,
    desc = 'Ask opencode',
    mode = { 'n', 'v' },
  },
  {
    '<leader>ap',
    function() opencode.prompt '@this: ' end,
    desc = 'Append to opencode prompt',
    mode = { 'n', 'v' },
  },
  {
    '<leader>ac',
    function() start_tmux_server(true) end,
    desc = 'Continue opencode',
    mode = { 'n', 'v' },
  },
}

---@type opencode.Opts
vim.g.opencode_opts = {
  server = {
    url = opencode_port and ('http://localhost:%d'):format(opencode_port) or nil,
    start = start_tmux_server,
  },
}

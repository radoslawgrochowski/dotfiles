local opencode = require 'opencode'

local wk = require 'which-key'
local kitty_socket = vim.env.KITTY_LISTEN_ON or 'unix:/tmp/kitty'
local kitty_location = 'tab'
local kitty_window_id
local opencode_port_base = 20000
local opencode_port_range = 20000

local function get_opencode_port_seed()
  -- Prefer Kitty's per-window id over the outer terminal window id.
  return vim.env.KITTY_WINDOW_ID or vim.env.WINDOWID or tostring(vim.fn.getpid())
end

local function get_opencode_port()
  local seed = get_opencode_port_seed()
  local numeric_seed = tonumber(seed)

  if numeric_seed then return opencode_port_base + (numeric_seed % opencode_port_range) end

  local hash = 0
  for i = 1, #seed do
    hash = (hash * 33 + seed:byte(i)) % opencode_port_range
  end

  return opencode_port_base + hash
end

local opencode_port = get_opencode_port()
local opencode_cmd = ('opencode-wrapper --port %d'):format(opencode_port)

local function disconnect_opencode()
  pcall(function() require('opencode.events').disconnect() end)
end

local function kitty_exec(args)
  local cmd = { 'kitty', '@', '--to', kitty_socket }
  vim.list_extend(cmd, args)

  local output = vim.fn.system(cmd)
  return vim.trim(output), vim.v.shell_error
end

local function get_kitty_window_id()
  if not kitty_window_id then return nil end

  local _, code = kitty_exec { 'ls', '--match', 'id:' .. kitty_window_id }
  if code ~= 0 then
    kitty_window_id = nil
    disconnect_opencode()
  end

  return kitty_window_id
end

local function sync_opencode_state() get_kitty_window_id() end

local function start_kitty_server()
  sync_opencode_state()
  if kitty_window_id then return end

  disconnect_opencode()

  local launch_cmd = {
    'launch',
    '--cwd=current',
    '--dont-take-focus',
    '--hold',
  }

  if kitty_location == 'tab' or kitty_location == 'os-window' then
    table.insert(launch_cmd, '--type=' .. kitty_location)
  else
    table.insert(launch_cmd, '--location=' .. kitty_location)
  end

  for arg in opencode_cmd:gmatch '%S+' do
    table.insert(launch_cmd, arg)
  end

  local stdout, code = kitty_exec(launch_cmd)
  if code == 0 then
    kitty_window_id = tonumber(stdout)
    return
  end

  vim.notify(
    'Failed to start opencode in kitty:\n' .. stdout,
    vim.log.levels.ERROR,
    { title = 'opencode' }
  )
end

local function stop_kitty_server()
  sync_opencode_state()

  local window_id = get_kitty_window_id()
  if not window_id then return end

  local stdout, code = kitty_exec { 'close-window', '--match', 'id:' .. window_id }
  if code == 0 then
    kitty_window_id = nil
    disconnect_opencode()
    return
  end

  vim.notify(
    'Failed to stop opencode kitty window:\n' .. stdout,
    vim.log.levels.ERROR,
    { title = 'opencode' }
  )
end

local function toggle_kitty_server()
  sync_opencode_state()

  if kitty_window_id then
    stop_kitty_server()
  else
    start_kitty_server()
  end
end

wk.add {
  {
    '<leader>ao',
    function()
      sync_opencode_state()
      opencode.start()
    end,
    desc = 'Open opencode',
    mode = { 'n', 'v' },
  },
  {
    '<leader>aa',
    function()
      sync_opencode_state()
      opencode.ask '@this: '
    end,
    desc = 'Ask opencode',
    mode = { 'n', 'v' },
  },
}

---@type opencode.Opts
vim.g.opencode_opts = {
  server = {
    port = opencode_port,
    start = start_kitty_server,
    stop = stop_kitty_server,
    toggle = toggle_kitty_server,
  },
}

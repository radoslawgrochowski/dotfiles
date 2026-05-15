local function notify_error(lines)
  vim.notify(table.concat(lines, '\n'), vim.log.levels.ERROR, { title = 'UpdateNixFetchgit' })
end

local function get_update_locations(bufnr, line1, line2)
  local locations = {}
  local lines = vim.api.nvim_buf_get_lines(bufnr, line1 - 1, line2, false)

  for index, line in ipairs(lines) do
    local first_non_blank = line:find '%S'

    if first_non_blank then
      table.insert(locations, string.format('--location=%d:%d', line1 + index - 1, first_non_blank))
    end
  end

  return locations
end

local function update_nix_fetchgit(opts)
  if vim.bo.filetype ~= 'nix' then
    notify_error { 'This command only works in Nix buffers.' }
    return
  end

  local bufnr = vim.api.nvim_get_current_buf()
  local lines = vim.api.nvim_buf_get_lines(bufnr, 0, -1, false)
  local command = { 'update-nix-fetchgit' }

  if opts.range > 0 then
    local locations = get_update_locations(bufnr, opts.line1, opts.line2)

    if vim.tbl_isempty(locations) then
      notify_error { 'The selection does not contain any non-blank lines.' }
      return
    end

    vim.list_extend(command, locations)
  end

  local view = vim.fn.winsaveview()
  local result = vim.system(command, { stdin = table.concat(lines, '\n'), text = true }):wait()

  if result.code ~= 0 then
    notify_error {
      result.stderr ~= '' and result.stderr or 'update-nix-fetchgit failed.',
    }
    return
  end

  local updated_lines = vim.split(result.stdout, '\n', { plain = true })

  if updated_lines[#updated_lines] == '' then
    table.remove(updated_lines)
  end

  vim.api.nvim_buf_set_lines(bufnr, 0, -1, false, updated_lines)
  vim.fn.winrestview(view)
end

vim.api.nvim_create_user_command('UpdateNixFetchgit', update_nix_fetchgit, {
  desc = 'Update nix fetcher hashes in the buffer or selected lines',
  range = true,
})

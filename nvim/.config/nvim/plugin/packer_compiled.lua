-- Automatically generated packer.nvim plugin loader code

if vim.api.nvim_call_function('has', {'nvim-0.5'}) ~= 1 then
  vim.api.nvim_command('echohl WarningMsg | echom "Invalid Neovim version for packer.nvim! | echohl None"')
  return
end

vim.api.nvim_command('packadd packer.nvim')

local no_errors, error_msg = pcall(function()

  local time
  local profile_info
  local should_profile = false
  if should_profile then
    local hrtime = vim.loop.hrtime
    profile_info = {}
    time = function(chunk, start)
      if start then
        profile_info[chunk] = hrtime()
      else
        profile_info[chunk] = (hrtime() - profile_info[chunk]) / 1e6
      end
    end
  else
    time = function(chunk, start) end
  end
  
local function save_profiles(threshold)
  local sorted_times = {}
  for chunk_name, time_taken in pairs(profile_info) do
    sorted_times[#sorted_times + 1] = {chunk_name, time_taken}
  end
  table.sort(sorted_times, function(a, b) return a[2] > b[2] end)
  local results = {}
  for i, elem in ipairs(sorted_times) do
    if not threshold or threshold and elem[2] > threshold then
      results[i] = elem[1] .. ' took ' .. elem[2] .. 'ms'
    end
  end

  _G._packer = _G._packer or {}
  _G._packer.profile_output = results
end

time([[Luarocks path setup]], true)
local package_path_str = "/home/radoslawgrochowski/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?.lua;/home/radoslawgrochowski/.cache/nvim/packer_hererocks/2.1.0-beta3/share/lua/5.1/?/init.lua;/home/radoslawgrochowski/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?.lua;/home/radoslawgrochowski/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/luarocks/rocks-5.1/?/init.lua"
local install_cpath_pattern = "/home/radoslawgrochowski/.cache/nvim/packer_hererocks/2.1.0-beta3/lib/lua/5.1/?.so"
if not string.find(package.path, package_path_str, 1, true) then
  package.path = package.path .. ';' .. package_path_str
end

if not string.find(package.cpath, install_cpath_pattern, 1, true) then
  package.cpath = package.cpath .. ';' .. install_cpath_pattern
end

time([[Luarocks path setup]], false)
time([[try_loadstring definition]], true)
local function try_loadstring(s, component, name)
  local success, result = pcall(loadstring(s), name, _G.packer_plugins[name])
  if not success then
    vim.schedule(function()
      vim.api.nvim_notify('packer.nvim: Error running ' .. component .. ' for ' .. name .. ': ' .. result, vim.log.levels.ERROR, {})
    end)
  end
  return result
end

time([[try_loadstring definition]], false)
time([[Defining packer_plugins]], true)
_G.packer_plugins = {
  LuaSnip = {
    config = { "\27LJ\2\0025\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\26user.plugins.snippets\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/LuaSnip",
    url = "https://github.com/L3MON4D3/LuaSnip"
  },
  ["cmp-buffer"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/cmp-buffer",
    url = "https://github.com/hrsh7th/cmp-buffer"
  },
  ["cmp-cmdline"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/cmp-cmdline",
    url = "https://github.com/hrsh7th/cmp-cmdline"
  },
  ["cmp-nvim-lsp"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp"
  },
  ["cmp-nvim-lsp-signature-help"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/cmp-nvim-lsp-signature-help",
    url = "https://github.com/hrsh7th/cmp-nvim-lsp-signature-help"
  },
  ["cmp-path"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/cmp-path",
    url = "https://github.com/hrsh7th/cmp-path"
  },
  cmp_luasnip = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/cmp_luasnip",
    url = "https://github.com/saadparwaiz1/cmp_luasnip"
  },
  ["gitsigns.nvim"] = {
    config = { "\27LJ\2\0025\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\26user.plugins.gitsigns\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/gitsigns.nvim",
    url = "https://github.com/lewis6991/gitsigns.nvim"
  },
  ["goyo.vim"] = {
    config = { "\27LJ\2\2b\0\0\5\0\6\0\n6\0\0\0'\1\1\0B\0\2\0029\0\2\0\18\1\0\0'\2\3\0'\3\4\0'\4\5\0B\1\4\1K\0\1\0\18<cmd>Goyo<cr>\14<leader>g\6n\vkeymap\14lib.utils\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/goyo.vim",
    url = "https://github.com/junegunn/goyo.vim"
  },
  ["limelight.vim"] = {
    config = { "\27LJ\2\2�\1\0\0\2\0\5\1\t6\0\0\0009\0\1\0*\1\0\0=\1\2\0006\0\0\0009\0\3\0'\1\4\0B\0\2\1K\0\1\0b \n        autocmd! User GoyoEnter Limelight\n        autocmd! User GoyoLeave Limelight!\n      \bcmd\"limelight_default_coefficient\6g\bvim��̙\19����\3\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/limelight.vim",
    url = "https://github.com/junegunn/limelight.vim"
  },
  ["lspkind.nvim"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/lspkind.nvim",
    url = "https://github.com/onsails/lspkind.nvim"
  },
  ["lualine.nvim"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/lualine.nvim",
    url = "https://github.com/nvim-lualine/lualine.nvim"
  },
  ["nvim-cmp"] = {
    config = { "\27LJ\2\0020\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\21user.plugins.cmp\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/nvim-cmp",
    url = "https://github.com/hrsh7th/nvim-cmp"
  },
  ["nvim-code-action-menu"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/nvim-code-action-menu",
    url = "https://github.com/weilbith/nvim-code-action-menu"
  },
  ["nvim-lspconfig"] = {
    config = { "\27LJ\2\0026\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\27user.plugins.lspconfig\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/nvim-lspconfig",
    url = "https://github.com/neovim/nvim-lspconfig"
  },
  ["nvim-tree.lua"] = {
    config = { "\27LJ\2\0026\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\27user.plugins.nvim-tree\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/nvim-tree.lua",
    url = "https://github.com/kyazdani42/nvim-tree.lua"
  },
  ["nvim-treesitter"] = {
    config = { "\27LJ\2\0029\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16spellsitter\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/nvim-treesitter",
    url = "https://github.com/nvim-treesitter/nvim-treesitter"
  },
  ["nvim-web-devicons"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/nvim-web-devicons",
    url = "https://github.com/kyazdani42/nvim-web-devicons"
  },
  ["packer.nvim"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/packer.nvim",
    url = "https://github.com/wbthomason/packer.nvim"
  },
  ["plenary.nvim"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/plenary.nvim",
    url = "https://github.com/nvim-lua/plenary.nvim"
  },
  ["schemastore.nvim"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/schemastore.nvim",
    url = "https://github.com/b0o/schemastore.nvim"
  },
  ["spellsitter.nvim"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/spellsitter.nvim",
    url = "https://github.com/lewis6991/spellsitter.nvim"
  },
  ["telescope-fzf-native.nvim"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/telescope-fzf-native.nvim",
    url = "https://github.com/nvim-telescope/telescope-fzf-native.nvim"
  },
  ["telescope-live-grep-args.nvim"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/telescope-live-grep-args.nvim",
    url = "https://github.com/nvim-telescope/telescope-live-grep-args.nvim"
  },
  ["telescope.nvim"] = {
    config = { "\27LJ\2\0026\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\27user.plugins.telescope\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/telescope.nvim",
    url = "https://github.com/nvim-telescope/telescope.nvim"
  },
  ["tokyodark.nvim"] = {
    config = { "\27LJ\2\0026\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\27user.plugins.tokyodark\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/tokyodark.nvim",
    url = "https://github.com/tiagovla/tokyodark.nvim"
  },
  undotree = {
    config = { "\27LJ\2\0026\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\27user.plugins.tokyodark\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/undotree",
    url = "https://github.com/mbbill/undotree"
  },
  ["vim-commentary"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-commentary",
    url = "https://github.com/tpope/vim-commentary"
  },
  ["vim-eunuch"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-eunuch",
    url = "https://github.com/tpope/vim-eunuch"
  },
  ["vim-fugitive"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-fugitive",
    url = "https://github.com/tpope/vim-fugitive"
  },
  ["vim-heritage"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-heritage",
    url = "https://github.com/jessarcher/vim-heritage"
  },
  ["vim-lastplace"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-lastplace",
    url = "https://github.com/farmergreg/vim-lastplace"
  },
  ["vim-pasta"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-pasta",
    url = "https://github.com/sickill/vim-pasta"
  },
  ["vim-projectionist"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-projectionist",
    url = "https://github.com/tpope/vim-projectionist"
  },
  ["vim-rooter"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-rooter",
    url = "https://github.com/airblade/vim-rooter"
  },
  ["vim-sleuth"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-sleuth",
    url = "https://github.com/tpope/vim-sleuth"
  },
  ["vim-surround"] = {
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-surround",
    url = "https://github.com/tpope/vim-surround"
  },
  ["vim-test"] = {
    config = { "\27LJ\2\0021\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\22user.plugins.test\frequire\0" },
    loaded = true,
    path = "/home/radoslawgrochowski/.local/share/nvim/site/pack/packer/start/vim-test",
    url = "https://github.com/vim-test/vim-test"
  }
}

time([[Defining packer_plugins]], false)
-- Config for: nvim-treesitter
time([[Config for nvim-treesitter]], true)
try_loadstring("\27LJ\2\0029\0\0\2\0\3\0\0066\0\0\0'\1\1\0B\0\2\0029\0\2\0B\0\1\1K\0\1\0\nsetup\16spellsitter\frequire\0", "config", "nvim-treesitter")
time([[Config for nvim-treesitter]], false)
-- Config for: nvim-cmp
time([[Config for nvim-cmp]], true)
try_loadstring("\27LJ\2\0020\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\21user.plugins.cmp\frequire\0", "config", "nvim-cmp")
time([[Config for nvim-cmp]], false)
-- Config for: nvim-tree.lua
time([[Config for nvim-tree.lua]], true)
try_loadstring("\27LJ\2\0026\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\27user.plugins.nvim-tree\frequire\0", "config", "nvim-tree.lua")
time([[Config for nvim-tree.lua]], false)
-- Config for: vim-test
time([[Config for vim-test]], true)
try_loadstring("\27LJ\2\0021\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\22user.plugins.test\frequire\0", "config", "vim-test")
time([[Config for vim-test]], false)
-- Config for: limelight.vim
time([[Config for limelight.vim]], true)
try_loadstring("\27LJ\2\2�\1\0\0\2\0\5\1\t6\0\0\0009\0\1\0*\1\0\0=\1\2\0006\0\0\0009\0\3\0'\1\4\0B\0\2\1K\0\1\0b \n        autocmd! User GoyoEnter Limelight\n        autocmd! User GoyoLeave Limelight!\n      \bcmd\"limelight_default_coefficient\6g\bvim��̙\19����\3\0", "config", "limelight.vim")
time([[Config for limelight.vim]], false)
-- Config for: goyo.vim
time([[Config for goyo.vim]], true)
try_loadstring("\27LJ\2\2b\0\0\5\0\6\0\n6\0\0\0'\1\1\0B\0\2\0029\0\2\0\18\1\0\0'\2\3\0'\3\4\0'\4\5\0B\1\4\1K\0\1\0\18<cmd>Goyo<cr>\14<leader>g\6n\vkeymap\14lib.utils\frequire\0", "config", "goyo.vim")
time([[Config for goyo.vim]], false)
-- Config for: gitsigns.nvim
time([[Config for gitsigns.nvim]], true)
try_loadstring("\27LJ\2\0025\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\26user.plugins.gitsigns\frequire\0", "config", "gitsigns.nvim")
time([[Config for gitsigns.nvim]], false)
-- Config for: tokyodark.nvim
time([[Config for tokyodark.nvim]], true)
try_loadstring("\27LJ\2\0026\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\27user.plugins.tokyodark\frequire\0", "config", "tokyodark.nvim")
time([[Config for tokyodark.nvim]], false)
-- Config for: nvim-lspconfig
time([[Config for nvim-lspconfig]], true)
try_loadstring("\27LJ\2\0026\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\27user.plugins.lspconfig\frequire\0", "config", "nvim-lspconfig")
time([[Config for nvim-lspconfig]], false)
-- Config for: telescope.nvim
time([[Config for telescope.nvim]], true)
try_loadstring("\27LJ\2\0026\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\27user.plugins.telescope\frequire\0", "config", "telescope.nvim")
time([[Config for telescope.nvim]], false)
-- Config for: undotree
time([[Config for undotree]], true)
try_loadstring("\27LJ\2\0026\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\27user.plugins.tokyodark\frequire\0", "config", "undotree")
time([[Config for undotree]], false)
-- Config for: LuaSnip
time([[Config for LuaSnip]], true)
try_loadstring("\27LJ\2\0025\0\0\2\0\2\0\0046\0\0\0'\1\1\0B\0\2\1K\0\1\0\26user.plugins.snippets\frequire\0", "config", "LuaSnip")
time([[Config for LuaSnip]], false)
if should_profile then save_profiles() end

end)

if not no_errors then
  error_msg = error_msg:gsub('"', '\\"')
  vim.api.nvim_command('echohl ErrorMsg | echom "Error in packer_compiled: '..error_msg..'" | echom "Please check your config for correctness" | echohl None')
end

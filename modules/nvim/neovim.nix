{ pkgs, lib, ... }:
with lib; let
  mkNeovim = pkgs.callPackage ./lib/mkNeovim.nix { };
  getModule = m: pkgs.callPackage m { };
  concatModules = packages: {
    allPlugins = concatLists
      (map (pkg: (getModule pkg).plugins or [ ]) packages);
    allExtraPackages = concatLists
      (map (pkg: (getModule pkg).extraPackages or [ ]) packages);
    allConfigs = concatStrings
      (map (pkg: (getModule pkg).config or "") packages);
  };

  mainConfig = builtins.readFile ./config.lua;
  modules = concatModules [
    ./plugins/utility
    ./plugins/mini
    ./plugins/treesitter
    ./plugins/git
    ./plugins/lsp
    ./plugins/oil
    ./plugins/telescope
    ./plugins/theme
    ./plugins/cmp
    ./plugins/test
    ./plugins/dap
  ];

  plugins = modules.allPlugins;
  extraPackages = modules.allExtraPackages;
  config = mainConfig + modules.allConfigs;
in
{
  nvim-rg = mkNeovim {
    inherit plugins;
    inherit extraPackages;
    inherit config;
  };

  nvim-luarc-json = pkgs.mk-luarc-json {
    inherit plugins;
  };

}

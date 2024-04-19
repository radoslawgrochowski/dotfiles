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

  modules = concatModules [
    ./plugins/treesitter
    ./plugins/utility
  ];

  plugins = modules.allPlugins;
  extraPackages = modules.allExtraPackages;
  config = modules.allConfigs;
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

  programs.bash.shellAliases = { vimdiff = "nvim -d"; };
  programs.fish.shellAliases = { vimdiff = "nvim -d"; };
  programs.zsh.shellAliases = { vimdiff = "nvim -d"; };
}

{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    telescope-nvim
    telescope-fzf-native-nvim
    telescope-frecency-nvim
  ];
  extraPackages = with pkgs; [
    ripgrep
    fd
  ];
  config = builtins.readFile ./config.lua;
} 

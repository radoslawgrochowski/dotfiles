{ pkgs }:
{
  plugins = [ pkgs.unstable.vimPlugins.mini-nvim ];
  config = builtins.readFile ./config.lua;
} 

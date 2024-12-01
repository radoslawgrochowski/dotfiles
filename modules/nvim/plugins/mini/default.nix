{ pkgs }:
{
  plugins = [ pkgs.vimPlugins.mini-nvim ];
  config = builtins.readFile ./config.lua;
} 

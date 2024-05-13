{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ oil-nvim ];
  config = builtins.readFile ./config.lua;
} 

{ pkgs }:
{
  plugins = with pkgs.unstable.vimPlugins; [ oil-nvim ];
  config = builtins.readFile ./config.lua;
} 

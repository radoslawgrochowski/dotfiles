{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    vim-fugitive

    # Bitbucket extensions for fugitive
    vim-fubitive

    # Github extensions for fugitive
    vim-rhubarb
  ];
  config = builtins.readFile ./config.lua;
} 

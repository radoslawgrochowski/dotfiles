{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    vim-fugitive
  ];
} 

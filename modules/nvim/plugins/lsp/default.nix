{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ 
    nvim-lspconfig
    fidget-nvim
  ];
  extraPackages = with pkgs; [
    nil 
  ];
  config = builtins.readFile ./config.lua;
} 

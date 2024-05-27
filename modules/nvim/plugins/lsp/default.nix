{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [ 
    efmls-configs-nvim
    fidget-nvim
    nvim-lspconfig
  ];
  extraPackages = with pkgs; [
    efm-langserver
    lua-language-server
    nil 
    stylua
  ];
  config = builtins.readFile ./config.lua;
} 

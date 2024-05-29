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
    nodePackages.typescript
    nodePackages.typescript-language-server
    stylua
  ];
  config = builtins.readFile ./config.lua;
} 

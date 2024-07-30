{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    efmls-configs-nvim
    fidget-nvim
    nvim-lspconfig
    lsp-format-nvim
  ];
  extraPackages = with pkgs; [
    efm-langserver
    lua-language-server
    nil
    nodePackages.typescript
    nodePackages.typescript-language-server
    localNodePackages."@vtsls/language-server"
    nixpkgs-fmt
    stylua
  ];
  config = builtins.readFile ./config.lua;
} 

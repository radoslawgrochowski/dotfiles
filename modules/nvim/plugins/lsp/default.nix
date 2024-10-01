{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    efmls-configs-nvim
    fidget-nvim
    nvim-lspconfig
    lsp-format-nvim
    ltex_extra-nvim
    pkgs.localVimPlugins.vtsls-nvim
    SchemaStore-nvim
  ];
  extraPackages = with pkgs; [
    efm-langserver
    lua-language-server
    nil
    ltex-ls
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    localNodePackages."@vtsls/language-server"
    localNodePackages.vscode-langservers-extracted
    nixpkgs-fmt
    stylua
  ];
  config = builtins.readFile ./config.lua;
} 

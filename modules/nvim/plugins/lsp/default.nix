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
    localNodePackages."@vtsls/language-server"
    localNodePackages.vscode-langservers-extracted
    localNodePackages."@mdx-js/language-server"
    localNodePackages."@tailwindcss/language-server"
    ltex-ls
    lua-language-server
    nil
    nixpkgs-fmt
    nodePackages.bash-language-server
    nodePackages.prettier
    nodePackages.typescript
    nodePackages.typescript-language-server
    nodePackages.yaml-language-server
    shellcheck
    shfmt
    stylua
  ];
  config = builtins.readFile ./config.lua;
} 


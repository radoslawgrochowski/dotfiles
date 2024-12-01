{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    efmls-configs-nvim
    fidget-nvim
    nvim-lspconfig
    lsp-format-nvim
    ltex_extra-nvim
    SchemaStore-nvim
  ];
  extraPackages = with pkgs; [
    efm-langserver
    localNodePackages."@vtsls/language-server"
    localNodePackages.vscode-langservers-extracted
    localNodePackages."@mdx-js/language-server"
    localNodePackages."@tailwindcss/language-server"
    localNodePackages."@astrojs/language-server"
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
    elixir
    elixir-ls
  ];
  config = /* lua */''
    ELIXIR_LS_PATH = '${"${pkgs.elixir-ls}"}/bin/elixir-ls';
    ${builtins.readFile ./config.lua}
  '';
} 


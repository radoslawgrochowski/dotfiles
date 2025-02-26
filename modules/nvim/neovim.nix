{ pkgs, lib, ... }:
with lib; let
  mkNeovim = pkgs.callPackage ./lib/mkNeovim.nix { };
  mkLuarcJson = pkgs.callPackage ./lib/mkLuarcJson.nix { };

  plugins = with pkgs.vimPlugins; with pkgs.localVimPlugins; [
    nvim-nio
    plenary-nvim
    which-key-nvim
    nvim-web-devicons

    mini-nvim

    nvim-treesitter-context
    nvim-treesitter.withAllGrammars
    nvim-ts-autotag
    nvim-ts-context-commentstring

    vim-fugitive
    vim-fubitive
    vim-rhubarb
    gitsigns-nvim

    efmls-configs-nvim
    fidget-nvim
    nvim-lspconfig
    lsp-format-nvim
    ltex_extra-nvim
    SchemaStore-nvim

    oil-nvim

    telescope-nvim
    telescope-fzf-native-nvim
    telescope-ui-select-nvim

    tokyonight-nvim
    telescope-nvim
    render-markdown-nvim

    nvim-cmp
    cmp-buffer
    cmp-cmdline
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-path
    cmp-rg

    FixCursorHold-nvim
    neotest
    neotest-jest

    nvim-nio
    nvim-dap
    nvim-dap-ui
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

    ripgrep
    fd
    vscode-js-debug
  ];

  luaPaths = /* lua */''
    vim.g.js_debug_path = '${"${pkgs.vscode-js-debug}"}/bin/js-debug';
    vim.g.elixir_ls_path = '${"${pkgs.elixir-ls}"}/bin/elixir-ls';
  '';
in
{
  nvim-rg = mkNeovim {
    inherit plugins;
    inherit extraPackages;
    extraInitLua = luaPaths;
    configDir = ./nvim;
  };

  nvim-luarc-json = mkLuarcJson {
    inherit plugins;
  };
}

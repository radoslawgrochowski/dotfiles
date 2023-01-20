{ config, lib, pkgs, inputs, ... }:

let
  # concatFiles = files:
  #   pkgs.lib.strings.concatMapStringsSep "\n" builtins.readFile files;
  #
  # installs a vim plugin from git with a given tag / branch
  # usage: pluginGit "HEAD" "ellisonleao/gruvbox.nvim");
  # pluginGit = ref: repo: pkgs.vimUtils.buildVimPluginFrom2Nix {
  #   pname = "${lib.strings.sanitizeDerivationName repo}";
  #   version = ref;
  #   src = builtins.fetchGit {
  #     url = "https://github.com/${repo}.git";
  #     ref = ref;
  #   };
  # };

in

{
  # home.file."./.config/nvim/init.lua".source =
  #   config.lib.file.mkOutOfStoreSymlink "${inputs.self}/nvim/config.lua";

  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      efm-langserver
      gcc
      git
      rnix-lsp
      ripgrep
      sumneko-lua-language-server
      tree-sitter
      wget
      xclip
      nodePackages.prettier
      nodePackages.bash-language-server
      nodePackages.typescript-language-server
      nodePackages.vscode-langservers-extracted
      haskell-language-server
    ];
    viAlias = true;
    vimAlias = true;
    withNodeJs = true;
    withPython3 = true;

    # FIXME:
    # migrate config to lua somehow
    # (it's vim with heredoc lua syntax right now)
    extraConfig = builtins.readFile (./config.vim);

    plugins = with pkgs.vimPlugins; [
      plenary-nvim

      vim-rooter
      vim-lastplace
      vim-commentary
      vim-fugitive
      vim-projectionist
      vim-surround
      vim-sleuth
      vim-eunuch


      {
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile (./nvim-tree.lua);
      }

      lualine-lsp-progress
      lualine-nvim
      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = builtins.readFile (./tokyodark.lua);
      }

      {
        plugin = luasnip;
        type = "lua";
        config = builtins.readFile (./snippets.lua);
      }

      cmp-buffer
      cmp-cmdline
      cmp-nvim-lsp
      cmp-nvim-lsp-signature-help
      cmp-path
      lspkind-nvim
      cmp_luasnip
      {
        plugin = nvim-cmp;
        type = "lua";
        config = builtins.readFile (./cmp.lua);
      }

      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile (./treesitter.lua);
      }

      lsp-status-nvim
      SchemaStore-nvim
      nvim-code-action-menu
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile (./lspconfig.lua);
      }

      telescope-fzf-native-nvim
      nvim-web-devicons
      telescope-live-grep-args-nvim
      {
        plugin = telescope-nvim;
        type = "lua";
        config = builtins.readFile (./telescope.lua);
      }

      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile (./gitsigns.lua);
      }

      {
        plugin = vim-test;
        type = "lua";
        config = builtins.readFile (./test.lua);
      }

      lsp-colors-nvim
      {
        plugin = undotree;
        type = "lua";
        config = builtins.readFile (./undotree.lua);
      }
    ];
  };
}

{ config, lib, pkgs, inputs, ... }:

{
  programs.neovim = {
    enable = true;
    package = pkgs.neovim-unwrapped;
    extraPackages = with pkgs; [
      efm-langserver
      gcc
      git
      rnix-lsp
      ripgrep
      lua-language-server
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
    defaultEditor = true;

    # FIXME:
    # migrate config to lua somehow
    # (it's vim with heredoc lua syntax right now)
    extraConfig = builtins.readFile (./config.vim);

    plugins = with pkgs.vimPlugins; [
      # Util libraries
      plenary-nvim

      # Completion
      neodev-nvim
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

      {
        plugin = comment-nvim;
        type = "lua";
        config = "require('Comment').setup()";
      }
      vim-surround
      vim-sleuth
      vim-eunuch

      # Completion/Lsp
      SchemaStore-nvim
      nvim-code-action-menu
      lsp-colors-nvim
      {
        plugin = fidget-nvim;
        type = "lua";
        config = builtins.readFile (./fidget.lua);
      }
      {
        plugin = nvim-lspconfig;
        type = "lua";
        config = builtins.readFile (./lspconfig.lua);
      }

      # Movement

      ## need to test this more, it seems broken a bit
      {
        plugin = project-nvim;
        type = "lua";
        config = ''
          require("project_nvim").setup{}
        '';
      }
      vim-projectionist
      {
        plugin = vim-test;
        type = "lua";
        config = builtins.readFile (./test.lua);
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
        plugin = nvim-tree-lua;
        type = "lua";
        config = builtins.readFile (./nvim-tree.lua);
      }
      {
        plugin = undotree;
        type = "lua";
        config = builtins.readFile (./undotree.lua);
      }

      # Git 
      vim-fugitive
      {
        plugin = gitsigns-nvim;
        type = "lua";
        config = builtins.readFile (./gitsigns.lua);
      }

      # UI
      lualine-nvim
      lsp-status-nvim
      {
        plugin = tokyonight-nvim;
        type = "lua";
        config = builtins.readFile (./tokyodark.lua);
      }

      # Treesitter
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      {
        plugin = nvim-treesitter.withAllGrammars;
        type = "lua";
        config = builtins.readFile (./treesitter.lua);
      }
    ];
  };
}

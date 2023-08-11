{ username, pkgs, pkgs-stable, ... }:

{
  home-manager.users.${username} = {
    programs.neovim = {
      enable = true;
      package = pkgs.neovim-unwrapped;
      extraPackages = with pkgs; [
        efm-langserver
        gcc
        git
        ltex-ls
        lua-language-server
        marksman
        nil
        ripgrep
        rnix-lsp
        tree-sitter
        wget

        nodePackages.prettier
        nodePackages.bash-language-server
        nodePackages.typescript-language-server
        nodePackages.vscode-langservers-extracted
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
        {
          plugin = nvim-autopairs;
          type = "lua";
          config = "require('nvim-autopairs').setup()";
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
          plugin = pkgs-stable.vimPlugins.fidget-nvim;
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
        # {
        #   plugin = project-nvim;
        #   type = "lua";
        #   config = ''
        #     require("project_nvim").setup{}
        #   '';
        # }
        {
          plugin = other-nvim;
          type = "lua";
          config = builtins.readFile (./other.lua);
        }
        {
          plugin = vim-test;
          type = "lua";
          config = builtins.readFile (./test.lua);
        }
        telescope-fzf-native-nvim
        nvim-web-devicons
        {
          plugin = telescope-nvim;
          type = "lua";
          config = builtins.readFile (./telescope.lua);
        }
        {
          plugin = neo-tree-nvim;
          type = "lua";
          config = builtins.readFile (./neo-tree.lua);
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
        {
          plugin = lualine-nvim;
          type = "lua";
          config = builtins.readFile (./lualine.lua);
        }
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
        nvim-ts-autotag
        {
          plugin = nvim-treesitter.withAllGrammars;
          type = "lua";
          config = builtins.readFile (./treesitter.lua);
        }

        vim-lastplace
      ];
    };
  };
}

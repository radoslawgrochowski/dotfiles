{ username, pkgs, ... }:
let
  tokyoNight = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "5da1b76e64daf4c5d410f06bcb6b9cb640da7dfd";
    sha256 = "1s8qh9a8yajlfybcsky6rb31f0ihfhapm51531zn4xd0fyzy8dz3";
  };
  tokyoNightFishTheme = (builtins.readFile "${tokyoNight}/extras/fish/tokyonight_night.fish");
in
{
  programs.fish.enable = true;
  users.users.${username}.shell = pkgs.fish;
  environment.shells = with pkgs; [ fish ];
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      fd
      bat
    ];

    programs.fish = {
      enable = true;
      plugins = [
        {
          name = "fzf-fish";
          src = pkgs.fishPlugins.fzf-fish.src;
        }
        {
          name = "done";
          src = pkgs.fishPlugins.done.src;
        }
      ];
      interactiveShellInit = ''
        function fish_user_key_bindings
          fish_vi_key_bindings
        end
        set fish_greeting ""

        ${tokyoNightFishTheme}

        # Load local env vars if file exists
        if test -f "$HOME/.local/env.fish"
          source "$HOME/.local/env.fish"
        end
      '';
      shellAliases = {
        l = "ll";
        g = "git";
        G = "git";
      };
    };

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      settings = {
        palette = "tokyonight";
        palettes.tokyonight = {
          foreground = "#c0caf5";
          selection = "#33467c";
          comment = "#565f89";
          red = "#f7768e";
          orange = "#ff9e64";
          yellow = "#e0af68";
          green = "#9ece6a";
          purple = "#9d7cd8";
          cyan = "#7dcfff";
          pink = "#bb9af7";
        };

        battery.display = [ { threshold = 80; } ];
        git_metrics.disabled = false;

        # https://github.com/starship/starship/issues/6188
        nix_shell.format = "via [$symbol ($name)]($style) ";

        aws.symbol = " ";
        buf.symbol = " ";
        c.symbol = " ";
        conda.symbol = " ";
        dart.symbol = " ";
        directory.read_only = " 󰌾";
        docker_context.symbol = " ";
        elixir.symbol = " ";
        elm.symbol = " ";
        gcloud.symbol = " ";
        git_branch.symbol = " ";
        golang.symbol = " ";
        guix_shell.symbol = " ";
        haskell.symbol = " ";
        haxe.symbol = "⌘ ";
        hg_branch.symbol = " ";
        hostname.ssh_symbol = " ";
        java.symbol = " ";
        julia.symbol = " ";
        lua.symbol = " ";
        memory_usage.symbol = "󰍛 ";
        meson.symbol = "󰔷 ";
        nim.symbol = "󰆥 ";
        nix_shell.symbol = " ";
        nodejs.symbol = " ";
        ocaml.symbol = " ";
        package.symbol = "󰏗 ";
        python.symbol = " ";
        rlang.symbol = "󰟔 ";
        ruby.symbol = " ";
        rust.symbol = " ";
        scala.symbol = " ";
      };
    };

    programs.zoxide = {
      enable = true;
      enableFishIntegration = true;
    };

    programs.nix-index = {
      enableFishIntegration = true;
    };
  };
}

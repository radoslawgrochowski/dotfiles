{ username, pkgs, ... }:
let
  tokyoNight = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6";
    sha256 = "0kc1l1i7d8fsgq1snpzxjdmp4lp7h6mccp83zzn1w35vwxd93n3b";
  };
  tokyoNightFishTheme = (builtins.readFile "${tokyoNight}/extras/fish/tokyonight_night.fish");
in
{
  programs.fish.enable = true;
  users.users.${username}.shell = pkgs.fish;
  environment.shells = [ pkgs.fish ];
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      fd
      bat
    ];

    programs.fish = {
      enable = true;
      package = pkgs.fish;
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
      shellInit = ''
        if test -f "$HOME/.local/env.fish"
          source "$HOME/.local/env.fish"
        end
      '';
      interactiveShellInit = ''
        function fish_user_key_bindings
          fish_vi_key_bindings
        end
        set fish_greeting ""

        ${tokyoNightFishTheme}
      '';
    };

    programs.starship = {
      enable = true;
      enableFishIntegration = true;
      enableTransience = true;
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

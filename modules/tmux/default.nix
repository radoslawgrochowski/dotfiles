{ pkgs, ... }:
let
  tokyoNight = pkgs.fetchFromGitHub {
    owner = "folke";
    repo = "tokyonight.nvim";
    rev = "cdc07ac78467a233fd62c493de29a17e0cf2b2b6";
    sha256 = "0kc1l1i7d8fsgq1snpzxjdmp4lp7h6mccp83zzn1w35vwxd93n3b";
  };
  tokyoNightTmuxTheme = builtins.replaceStrings [ "" "" "" "" ] [ "" "" "" "" ] (
    builtins.readFile "${tokyoNight}/extras/tmux/tokyonight_night.tmux"
  );
in
{
  programs.tmux = {
    enable = true;
    extraConfig = ''
      ${builtins.readFile ./tmux.conf}

      ${tokyoNightTmuxTheme}

      set -g status-right "#{prefix_highlight}"
      setw -g window-status-separator "|"

      run-shell ${pkgs.tmuxPlugins.prefix-highlight.rtp}
      run-shell ${pkgs.tmuxPlugins.resurrect.rtp}
      run-shell ${pkgs.tmuxPlugins.continuum.rtp}
    '';
  };
}

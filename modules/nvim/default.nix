{
  config,
  username,
  pkgs,
  ...
}:
let
  nvim-rg = "${pkgs.nvim-rg}/bin/nvim";
  docker-path = pkgs.lib.makeBinPath [ pkgs.docker ];

  # Wrapper script to ensure opencode runs under fish with proper environment
  opencode-wrapper = pkgs.writeScriptBin "opencode-wrapper" ''
    #!${config.programs.fish.package}/bin/fish
    set -gx PATH ${docker-path} $PATH
    set -l port_args
    if set -q TMUX TMUX_PANE; and not contains -- --port $argv; and not string match -qr '^--port=' -- $argv
      set -l session_id (tmux display-message -p -t "$TMUX_PANE" '#{session_id}' | string replace '$' "")
      if string match -qr '^[0-9]+$' -- $session_id
        # Keep this port calculation in sync with plugin/opencode.lua.
        set port_args --port (math "20000 + $session_id % 20000")
      end
    end
    exec direnv exec . opencode $port_args $argv
  '';
in
{
  my.unfreePackages = [
    "vim-fubitive"
    "nvim-vtsls"
  ];

  environment.variables = {
    EDITOR = nvim-rg;
    GIT_EDITOR = nvim-rg;
    VISUAL = nvim-rg;
  };

  users.users."${username}".packages = [
    pkgs.nvim-rg
    opencode-wrapper
  ];

  environment.shellAliases = {
    opencode = "opencode-wrapper";
    vimdiff = "${nvim-rg} -d";
    nvim = nvim-rg;
    vim = nvim-rg;
    vi = nvim-rg;
  };

  nixpkgs.overlays = import ./overlays.nix;
}

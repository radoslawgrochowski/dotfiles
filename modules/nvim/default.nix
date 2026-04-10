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
    exec direnv exec . opencode $argv
  '';
in
{
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
    vimdiff = "${nvim-rg} -d";
    nvim = nvim-rg;
    vim = nvim-rg;
    vi = nvim-rg;
  };
}

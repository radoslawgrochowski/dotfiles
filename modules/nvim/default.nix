{ username, pkgs, ... }:
let
  nvim-rg = "${pkgs.nvim-rg}/bin/nvim";

  # Wrapper script to ensure opencode runs under fish with proper environment
  opencode-fish = pkgs.writeScriptBin "opencode-fish" ''
    #!${pkgs.fish}/bin/fish
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
    opencode-fish
  ];
  environment.shellAliases = {
    vimdiff = "${nvim-rg} -d";
    nvim = nvim-rg;
    vim = nvim-rg;
    vi = nvim-rg;
  };
}

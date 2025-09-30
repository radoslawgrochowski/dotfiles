{ username, pkgs, ... }:
let
  nvim-rg = "${pkgs.nvim-rg}/bin/nvim";
in
{
  environment.variables = {
    EDITOR = nvim-rg;
    GIT_EDITOR = nvim-rg;
    VISUAL = nvim-rg;
  };
  users.users."${username}".packages = [ pkgs.nvim-rg ];
  environment.shellAliases = {
    vimdiff = "${nvim-rg} -d";
    nvim = nvim-rg;
    vim = nvim-rg;
    vi = nvim-rg;
  };
}

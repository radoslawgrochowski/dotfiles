{ username, pkgs, ... }:
let
  nvim-rg = "${pkgs.nvim-rg}/bin/nvim";
  aliases = {
    vimdiff = "${nvim-rg} -d";
    nvim = nvim-rg;
    vim = nvim-rg;
    vi = nvim-rg;
  };
in
{
  environment.variables.EDITOR = nvim-rg;
  home-manager.users."${username}" = {
    programs.bash.shellAliases = aliases;
    programs.fish.shellAliases = aliases;
    programs.zsh.shellAliases = aliases;
  };
}



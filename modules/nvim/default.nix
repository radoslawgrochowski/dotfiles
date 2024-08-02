{ username, pkgs, ... }:
let
  nvim-rg = "${pkgs.nvim-rg}/bin/nvim";
  aliases = {
    vimdiff = "${nvim-rg} -d";
    nvim-rg = nvim-rg;
  };
in
{
  home-manager.users."${username}" = {
    programs.bash.shellAliases = aliases;
    programs.fish.shellAliases = aliases;
    programs.zsh.shellAliases = aliases;
  };
}



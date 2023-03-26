{ username, pkgs, ... }:

{
  home-manager.users.${username} = {
    home.packages = [ pkgs.git ];
    home.file."./.gitconfig".source = ./.gitconfig;
  };
}

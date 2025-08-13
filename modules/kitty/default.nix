{ username, pkgs, ... }:
{
  home-manager.users.${username} = {
    home.packages = [ pkgs.kitty ];
    home.file."./.config/kitty/kitty.conf".source = ./kitty.conf;
  };
}

      

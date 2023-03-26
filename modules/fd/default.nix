{ username, pkgs, ... }:

{
  home-manager.users.${username} = {
    home.packages = [ pkgs.fd ];
    home.file."./.config/fd/ignore".source = ./.fdignore;
  };
}

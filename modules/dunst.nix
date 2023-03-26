{ pkgs, username, ... }:

{
  home-manager.users.${username} = {
    home.packages = [ pkgs.dunst ];
    services.dunst = {
      enable = true;
    };
  };
}

{ config, pkgs, username, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      openjdk17
      opera
      steam-run
    ];
    services.udiskie.enable = true;
  };
}


{ config, pkgs, username, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      discord
      openjdk17
      opera
      steam-run
    ];
    services.udiskie.enable = true;
  };

  services.flatpak.enable = true;
}


{ username, pkgs, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      xdotool
    ];
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
      ];
      location = "bottom";
      extraConfig = {
        modi = "emoji,combi,drun,calc";
      };
      theme = ./spotlight-dark.rasi;
    };
  };
}

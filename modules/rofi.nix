{ username, pkgs, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      xdotool
    ];
    programs.rofi = {
      enable = true;
      plugins = with pkgs; [
        rofi-calc
        rofi-emoji
      ];
      location = "bottom";
      extraConfig = {
        modi = "emoji,combi,drun,calc";
      };
    };
  };
}

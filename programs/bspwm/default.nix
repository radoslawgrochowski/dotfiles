{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    xcwd
  ];

  xsession.windowManager.bspwm = {
    enable = true;
    startupPrograms = [
      "feh --randomize --bg-scale ~/Pictures/Wallpapers/*"
      "picom -b"
      "autorandr -c"
      "sh ~/scripts/autostart.sh"
      "mkdir ~/Drive -p && google-drive-ocamlfuse ~/Drive"
      "systemctl --user restart polybar"
    ];
    extraConfig = ''
      bspc monitor -d 1 2 3 4 5 6 7 8 9 10
      ${./split.sh}
      bspc config remove_disabled_monitors true
      bspc config remove_unplugged_monitors true
      bspc config merge_overlapping_monitors true 
    '';
    rules = {
      "Spotify" = {
        follow = true;
        rectangle = "1160x760+0+0";
        state = "pseudo_tiled";
      };
      "kitty" = {
        follow = true;
        rectangle = "680x320+0+0";
        state = "pseudo_tiled";
      };
    };
  };
}

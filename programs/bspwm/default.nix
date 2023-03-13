{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    bc
    bsp-layout
    xcwd
  ];

  xsession.windowManager.bspwm = {
    enable = true;
    startupPrograms = [
      "feh --randomize --bg-scale ~/Pictures/Wallpapers/*"
      "picom -b"
      "mkdir ~/Drives/rg@fard.pl -p && google-drive-ocamlfuse -label rg@fard.pl ~/Drives/rg@fard.pl"
      "systemctl --user restart polybar"
      "pgrep spotifywm || spotifywm"
      "pgrep btop || kitty --title btop --class btop btop"
    ];
    extraConfig = ''
      ${./split.sh}
      bspc config remove_disabled_monitors true
      bspc config remove_unplugged_monitors true
      bspc config merge_overlapping_monitors true 
      bspc config focused_border_color '#9ece6a'
      sh ${./monitor-order.sh}
      sh ${./split.sh}
    '';
    rules = {
      "Spotify" = {
        follow = true;
        rectangle = "1160x760+0+0";
        state = "pseudo_tiled";
        desktop = "Music";
      };
      "Microsoft Teams - Preview" = {
        follow = true;
        rectangle = "1660x960+0+0";
        state = "pseudo_tiled";
        desktop = "Comms";
      };
      "btop" = {
        follow = true;
        desktop = "^6";
      };
    };
  };
}

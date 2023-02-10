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
      "sh ~/scripts/autostart.sh"
      "mkdir ~/Drive -p && google-drive-ocamlfuse ~/Drive"
      "systemctl --user restart polybar"
    ];
    extraConfig = ''
      bspc config remove_disabled_monitors true
      bspc config remove_unplugged_monitors true
      bspc config merge_overlapping_monitors true 
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
      /* "kitty" = { */
      /*   follow = true; */
      /*   rectangle = "680x320+0+0"; */
      /*   state = "pseudo_tiled"; */
      /* }; */
    };
  };
}

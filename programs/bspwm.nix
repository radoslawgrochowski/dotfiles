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
      bspc config remove_disabled_monitors true
      bspc config remove_unplugged_monitors true
      bspc config merge_overlapping_monitors true 
    '';
  };
}

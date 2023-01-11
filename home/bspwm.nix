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
  };
}

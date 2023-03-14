{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    bc
    bsp-layout
    xdo
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
      bspc config remove_disabled_monitors true
      bspc config remove_unplugged_monitors true
      bspc config merge_overlapping_monitors true 
      bspc config focused_border_color '#9ece6a'
      sh ${./monitor-order.sh}
      sh ${./split.sh}

      xdo id -N Spotify | xargs -I{} -n1 bspc node {} -d 'Music'
      xdo id -N 'Microsoft Teams - Preview' | xargs -I{} -n1 bspc node {} -d 'Comms'
      xdo id -N 'btop' | xargs -I{} -n1 bspc node {} -d '^6'
    '';
    rules = {
      "Spotify" = {
        rectangle = "1160x760+0+0";
        state = "pseudo_tiled";
        desktop = "Music";
      };
      "Microsoft Teams - Preview" = {
        rectangle = "1660x960+0+0";
        state = "pseudo_tiled";
        desktop = "Comms";
      };
      "btop" = {
        desktop = "^6";
      };
    };
  };
}

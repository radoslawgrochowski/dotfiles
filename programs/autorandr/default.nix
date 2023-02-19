{ config, pkgs, inputs, lib, ... }:

{
  programs.autorandr = {
    enable = true;
    hooks = {
      postswitch = {
        "reload-bspwm" = "${pkgs.bspwm}/bin/bspc wm -r";
      };
    };
  };
  xsession.windowManager.bspwm.startupPrograms = [ "autorandr -c" ];
}

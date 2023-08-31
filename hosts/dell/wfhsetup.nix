{ pkgs, ... }:

let
  wfhsetup = pkgs.writeShellScriptBin "wfhsetup" ''
    set -e
    exec ${pkgs.wlr-randr}/bin/wlr-randr --output DP-2 --pos 0,0 --output eDP-1 --pos 200,1080 --output HDMI-A-1 --pos 1920,0
  ''; 
in {
  environment.systemPackages = [ wfhsetup ];
}

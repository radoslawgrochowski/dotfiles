{ config, pkgs, inputs, ... }:

{
  imports = [
    ./dunst.nix
    ./picom.nix
    ./polybar
    ./sxhkd
    ./notes-sync
    ./wallpapers-sync
  ];
}

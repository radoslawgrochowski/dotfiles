{ config, pkgs, inputs, ... }:

{
  imports = [
    ./dunst.nix
    ./picom.nix
    ./polybar
    ./sxhkd.nix
    ./notes
  ];
}

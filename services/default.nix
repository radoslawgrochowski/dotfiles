{ config, pkgs, inputs, ... }:

{
  imports = [
    ./dunst.nix
    ./picom.nix
    ./polybar
    ./sxkhd.nix
    ./notes
  ];
}

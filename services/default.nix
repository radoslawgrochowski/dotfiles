{ config, pkgs, inputs, ... }:

{
  imports = [
    ./dunst.nix
    ./notes-sync
    ./wallpapers-sync
  ];
}

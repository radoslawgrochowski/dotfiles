{ config, pkgs, inputs, ... }:

{
  imports = [
    ./picom.nix
    ./polybar.nix
    ./sxkhd.nix
  ];
}

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./autorandr
    ./bspwm.nix
    ./fish.nix
    ./git
    ./kitty
    ./nvim
    ./rofi.nix
  ];
}

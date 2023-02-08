{ config, pkgs, inputs, ... }:

{
  imports = [
    ./autorandr
    ./bspwm
    ./fd
    ./fish.nix
    ./git
    ./kitty
    ./nvim
    ./rofi.nix
  ];
}

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./autorandr
    ./bspwm.nix
    ./fd
    ./fish.nix
    ./git
    ./kitty
    ./nvim
    ./rofi.nix
  ];
}

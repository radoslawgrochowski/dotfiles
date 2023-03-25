{ config, pkgs, inputs, ... }:

{
  imports = [
    ./hyprland
    ./waybar
    ./fd
    ./fish.nix
    ./git
    ./kitty
    ./nvim
    ./rofi.nix
    ./npm
  ];
}

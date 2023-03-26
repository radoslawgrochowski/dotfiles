{ config, pkgs, inputs, ... }:

{
  imports = [
    ./fd
    ./git
    ./hyprland
    ./kitty
    ./notes-sync
    ./npm
    ./nvim
    ./wallpapers-sync
    ./waybar
    ./dunst.nix
    ./fish.nix
    ./fonts.nix
    ./home-manager.nix
    ./rofi.nix
  ];
}

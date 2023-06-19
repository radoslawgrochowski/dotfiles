{ config, pkgs, inputs, ... }:

{
  imports = [
    ./dunst
    ./fd
    ./git
    ./hyprland
    ./kitty
    ./notes-sync
    ./npm
    ./nvim
    ./wallpapers-sync
    ./waybar
    ./fish.nix
    ./fonts.nix
    ./gnupg.nix
    ./home-manager.nix
    ./rofi.nix
  ];
}

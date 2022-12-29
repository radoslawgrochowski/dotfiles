{ config, pkgs, inputs, ... }:

{
  imports = [
    ./autorandr.nix
    ./fish.nix
    ./fonts.nix
    ./git.nix
    ./i3.nix
    ./kitty.nix
    ./picom.nix
    ./polybar.nix
    ./rofi.nix
    ./scripts.nix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    btop 
    xcwd
    shutter
    spotify
    keepassxc
    google-drive-ocamlfuse
  ];

  home.stateVersion = "22.11";
}

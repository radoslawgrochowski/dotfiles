{ config, pkgs, inputs, ... }:

{
  imports = [
    ./fish.nix
    ./git.nix
    ./i3.nix
    ./kitty.nix
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
  ];

  home.stateVersion = "22.11";
}

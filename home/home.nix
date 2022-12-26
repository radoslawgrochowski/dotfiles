{ config, pkgs, inputs, ... }:

{
  imports = [
    ./git.nix
    ./i3.nix
    ./kitty.nix
    ./fish.nix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    btop 
  ];

  home.stateVersion = "22.11";
}

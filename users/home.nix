{ config, pkgs, inputs, hyprland, ... }:

{
  imports = [
    ./common.nix
  ];
  
  home.packages = with pkgs; [
    openjdk17
    opera
    steam-run
  ];

  services.udiskie.enable = true;
}


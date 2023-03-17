{ config, pkgs, inputs, ... }:

{
  imports = [
    ./common.nix
  ];

  home.packages = with pkgs; [
    openjdk17
    opera
    steam-run
  ];
}

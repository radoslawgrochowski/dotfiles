{ config, pkgs, inputs, ... }:

{
  imports = [
    ./common.nix
  ];

  home.packages = with pkgs; [
    haskellPackages.ghc
    openjdk17
    opera
    steam-run
  ];
}

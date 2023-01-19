{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.nerdfonts ];
  fonts.fontconfig.enable = true;
}

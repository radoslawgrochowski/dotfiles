{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.dunst ];
  services.dunst = {
    enable = true;
  };
}

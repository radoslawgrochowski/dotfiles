{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.git ];
  programs.neovim = {
    enable = true;
  };
}

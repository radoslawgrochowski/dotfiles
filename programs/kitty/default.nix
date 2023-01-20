{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.kitty ];
  home.file."./.config/kitty/kitty.conf".source =
    config.lib.file.mkOutOfStoreSymlink "${inputs.self}/programs/kitty/kitty.conf";
}

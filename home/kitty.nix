{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.kitty ];
  home.file."./.config/kitty".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/kitty";
}

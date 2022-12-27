{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.autorandr ];
  home.file."./.config/autorandr".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/autorandr";
}

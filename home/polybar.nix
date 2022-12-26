{ config, pkgs, inputs, ... }:

{
  home.packages = with pkgs; [
    polybar
  ];

  home.file."./.config/polybar".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/polybar/.config/polybar";
}

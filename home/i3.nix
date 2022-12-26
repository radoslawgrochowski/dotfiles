{ config, pkgs, inputs, ... }:

{
  home.file."./.config/i3".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/i3/.config/i3";
}

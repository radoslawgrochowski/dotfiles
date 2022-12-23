{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.git ];
  home.file."./.gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/git/.gitconfig";
}

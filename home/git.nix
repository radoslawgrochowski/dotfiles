{ config, pkgs, inputs, ... }:

{
  home.file."./.gitconfig".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/git/.gitconfig";
}

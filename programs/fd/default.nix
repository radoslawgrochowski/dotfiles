{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.fd ];
  home.file."./.config/fd/ignore".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/programs/fd/.fdignore";
}

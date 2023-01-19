{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.fd ];
  home.file."./.fdignore".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/programs/fd/.fdignore";
}

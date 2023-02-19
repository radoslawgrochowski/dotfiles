{ config, pkgs, inputs, ... }:

{
  home.packages = [ pkgs.fd ];
  home.file."./.config/fd/ignore".source = ./.fdignore;
}

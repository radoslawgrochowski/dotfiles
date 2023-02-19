{ config, pkgs, inputs, ... }:

{
  home.file."./.npmrc".source = ./.npmrc;
}

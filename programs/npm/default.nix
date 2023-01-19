{ config, pkgs, inputs, ... }:

{
  home.file."./.npmrc".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/programs/npm/.npmrc";
}

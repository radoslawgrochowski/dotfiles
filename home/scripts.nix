{ config, pkgs, inputs, ... }:

{
  home.file."scripts".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/scripts";
}

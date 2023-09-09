{ pkgs, lib, username, ... }:

let
  version = "3.22.10002";
  awakenedpoetrade = pkgs.appimageTools.wrapType2 {
    name = "awakened-poe-trade";
    version = "${version}";

    src = pkgs.fetchurl {
      url = "https://github.com/SnosMe/awakened-poe-trade/releases/download/v${version}/Awakened-PoE-Trade-${version}.AppImage";
      sha256 = {
        "3.22.10002" = "sha256-h+VFEDzn49t4HidftOC9gSEUchrc74XkXRk1oYgEIfI=";
      }."${version}";
    };
  };
in
{
  home-manager.users.${username} = {
    home.packages = [
      awakenedpoetrade
    ];
  };
}

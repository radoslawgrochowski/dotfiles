{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs.steam.override ({ extraPkgs ? pkgs': [ ], ... }: {
      extraPkgs = pkgs': (extraPkgs pkgs') ++ (with pkgs'; [
        gamescope
        gtk3
        gtk3-x11
        keyutils
        libffi
        libgdiplus
        libkrb5
        libpng
        libpulseaudio
        libvorbis
        mangohud
        mono
        stdenv.cc.cc.lib
        xorg.libXScrnSaver
        xorg.libXcursor
        xorg.libXi
        xorg.libXinerama
        zlib
      ]);
    });
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}

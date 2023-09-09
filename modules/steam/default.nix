{ pkgs-stable, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs-stable.steam;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = true;
  };
}

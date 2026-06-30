(
  { pkgs, ... }:
  {
    my.unfreePackages = [ "spotify" ];
    environment.systemPackages = [
      pkgs.spotify
    ];
  }
)

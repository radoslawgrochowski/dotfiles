{ pkgs, username, ... }:
let
  nixpkgsPin = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/1b31087ac11ac1d2634ed938dd4761a917288938.tar.gz";
    sha256 = "0zhnqvkl1qw8apxx20g1p2qhbph6q37qgggnp3zqcp9i4hknaymd";
  }) { localSystem = pkgs.stdenv.hostPlatform.system; };
in
{
  users.users."${username}".packages = [ pkgs.opencode ];
  nixpkgs.overlays = [
    (final: prev: {
      opencode = (
        pkgs.symlinkJoin {
          name = "opencode";
          buildInputs = [ pkgs.makeWrapper ];
          paths = [
            (if pkgs.stdenv.hostPlatform.isLinux then nixpkgsPin.opencode else pkgs.unstable.opencode)
          ];
          postBuild = ''
            wrapProgram "$out/bin/opencode" \
              --set OPENCODE_CONFIG ${./opencode.json} \
              --set OPENCODE_TUI_CONFIG ${./tui.json}
          '';
        }
      );
    })
  ];
}

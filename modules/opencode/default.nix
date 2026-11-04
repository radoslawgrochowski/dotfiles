{ pkgs, username, ... }:
let
  opencodeConfig = (pkgs.formats.json { }).generate "opencode.json" (
    import ./config.nix { inherit (pkgs) lib; }
  );
  nixpkgsPin = import (fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/436e34e0bb929ffed9857ad34d74254ad5101d17.tar.gz"; # pin
    sha256 = "0dqjxam8xz8fwqsiqgaf8nnwf52wkp4fnc9l9v524s62pnyyizd1";
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
          paths = [ nixpkgsPin.opencode ];
          postBuild = ''
            wrapProgram "$out/bin/opencode" \
              --set OPENCODE_CONFIG ${opencodeConfig} \
              --set OPENCODE_TUI_CONFIG ${./tui.json}
          '';
        }
      );
    })
  ];
}

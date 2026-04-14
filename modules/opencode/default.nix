{ pkgs, username, ... }:
{
  users.users."${username}".packages = with pkgs; [ opencode ];
  nixpkgs.overlays = [
    (final: prev: {
      opencode = (
        pkgs.symlinkJoin {
          name = "opencode";
          buildInputs = [ pkgs.makeWrapper ];
          paths = [ pkgs.master.opencode ];
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

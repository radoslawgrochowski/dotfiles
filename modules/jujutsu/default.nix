{
  config,
  pkgs,
  username,
  ...
}:
{
  users.users."${username}".packages = with pkgs; [ jujutsu ];
  nixpkgs.overlays = [
    (final: prev: {
      jujutsu = (
        prev.symlinkJoin {
          name = "jj";
          buildInputs = [ prev.makeWrapper ];
          paths = [ prev.jujutsu ];
          postBuild = ''
            wrapProgram "$out/bin/jj" \
              --set JJ_CONFIG ${./config.toml}:${config.users.users.${username}.home}/.config/jj
          '';
        }
      );
    })
  ];
}

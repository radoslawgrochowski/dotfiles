{
  config,
  pkgs,
  username,
  ...
}:
let
  copyIgnoredFromRoot = pkgs.writeShellApplication {
    name = "jj-copy-ignored-from-root";
    runtimeInputs = [
      pkgs.git
      pkgs.rsync
    ];
    text = builtins.readFile ./jj-copy-ignored-from-root.sh;
  };

  jjConfig = (pkgs.formats.toml { }).generate "jj-config.toml" {
    user = {
      name = "Radosław Grochowski";
    };
    ui = {
      default-command = "log";
    };
    aliases = {
      "cp-ignored-from-root" = [
        "util"
        "exec"
        "--"
        (pkgs.lib.getExe copyIgnoredFromRoot)
      ];
    };
  };

  jjConfigPaths = builtins.map builtins.toString [
    jjConfig
    "${config.users.users.${username}.home}/.config/jj"
  ];
in
{
  users.users."${username}".packages = with pkgs; [ jujutsu ];
  nixpkgs.overlays = [
    (final: prev: {
      jujutsu = (
        prev.symlinkJoin {
          name = "jj";
          buildInputs = [ prev.makeWrapper ];
          paths = [ pkgs.master.jujutsu ];
          postBuild = ''
            wrapProgram "$out/bin/jj" \
              --set JJ_CONFIG ${builtins.concatStringsSep ":" jjConfigPaths}
          '';
        }
      );
    })
  ];
}

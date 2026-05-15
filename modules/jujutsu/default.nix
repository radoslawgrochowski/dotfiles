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
    merge-tools.diffconflicts = {
      program = "nvim";
      merge-args = [
        "-c"
        "let g:jj_diffconflicts_marker_length=$marker_length"
        "-c"
        "JJDiffConflicts!"
        "$output"
        "$base"
        "$left"
        "$right"
      ];
      merge-tool-edits-conflict-markers = true;
    };
    aliases = {
      "cp-ignored-from-root" = [
        "util"
        "exec"
        "--"
        (pkgs.lib.getExe copyIgnoredFromRoot)
      ];
    };
    remotes.origin = {
      auto-track-bookmarks = "rg/*";
      auto-track-created-bookmarks = "*";
    };
  };

  baseConfigDir = "${config.users.users.${username}.home}.config/jj";

  jjConfigPaths = builtins.map builtins.toString [
    baseConfigDir
    jjConfig
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

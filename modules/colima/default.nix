{
  config,
  lib,
  options,
  pkgs,
  username,
  ...
}:
let
  userHome = lib.removeSuffix "/" config.users.users."${username}".home;
in
{
  config = lib.optionalAttrs (builtins.hasAttr "launchd" options) {
    users.users."${username}".packages = [
      pkgs.colima
      pkgs.docker-client
    ];

    launchd.user.agents.colima = {
      path = [
        pkgs.colima
        pkgs.docker-client
        pkgs.lima
        pkgs.qemu
        "/usr/bin"
        "/bin"
        "/usr/sbin"
        "/sbin"
      ];

      serviceConfig = {
        ProgramArguments = [
          "${pkgs.colima}/bin/colima"
          "start"
        ];
        RunAtLoad = true;
        StandardOutPath = "${userHome}/Library/Logs/colima.log";
        StandardErrorPath = "${userHome}/Library/Logs/colima.log";
        EnvironmentVariables = {
          HOME = userHome;
          USER = username;
        };
      };
    };
  };
}

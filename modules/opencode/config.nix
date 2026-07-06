{ lib }:
let
  withWildcard = command: [
    command
    "${command} *"
  ];

  allowRules =
    commands:
    builtins.listToAttrs (
      map (command: {
        name = command;
        value = "allow";
      }) commands
    );

  jjReadOnly = lib.concatMap withWildcard [
    "jj help"
    "jj version"
    "jj root"
    "jj status"
    "jj st"
    "jj log"
    "jj l"
    "jj diff"
    "jj d"
    "jj describe"
    "jj show"
    "jj file show"
    "jj file list"
    "jj file annotate"
    "jj annotate"
    "jj obslog"
    "jj evolog"
    "jj interdiff"
    "jj branch list"
    "jj bookmark list"
    "jj tags"
    "jj config list"
    "jj config get"
    "jj git remote list"
    "jj workspace list"
    "jj sparse list"
    "jj op log"
  ];

  gcloudReadOnly = lib.concatMap withWildcard [
    "gcloud storage ls"
    "gcloud storage cat"
  ];

  readOnlyBashPermissions = allowRules (jjReadOnly ++ gcloudReadOnly);
in
{
  "$schema" = "https://opencode.ai/config.json";
  autoupdate = false;
  share = "disabled";

  permission.bash = readOnlyBashPermissions;

  agent.plan.permission.bash = {
    "*" = "ask";
  }
  // readOnlyBashPermissions;

  provider.openai.options.headerTimeout = 120000;

  mcp = {
    playwright = {
      type = "local";
      command = [
        "docker"
        "container"
        "run"
        "-i"
        "--rm"
        "--init"
        "--add-host=host.docker.internal:host-gateway"
        "mcr.microsoft.com/playwright/mcp"
      ];
      enabled = true;
    };

    nixos = {
      type = "local";
      command = [
        "docker"
        "run"
        "--rm"
        "-i"
        "ghcr.io/utensils/mcp-nixos"
      ];
      enabled = true;
    };
  };
}

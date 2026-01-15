{ pkgs, username, ... }:
{
  users.users."${username}".packages = [
    pkgs.opencode
  ];

  home-manager.users.${username} = {
    home.file."./.config/opencode/opencode.json".source = ./opencode.json;
  };
}

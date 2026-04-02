{ pkgs, username, ... }:
{
  users.users."${username}".packages = [
    pkgs.master.opencode
    pkgs.mcp-nixos
  ];

  home-manager.users.${username} = {
    home.file."./.config/opencode/opencode.json".source = ./opencode.json;
    home.file."./.config/opencode/tui.json".source = ./tui.json;
  };
}

{ pkgs, username, ... }: {
  users.users."${username}".packages = with pkgs;[
    pkgs.unstable.opencode
  ];

  home-manager.users.${username} = {
    home.file."./.config/opencode/opencode.json".source = ./opencode.json;
  };
}

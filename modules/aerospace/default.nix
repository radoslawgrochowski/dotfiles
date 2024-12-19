{ username, pkgs, ... }:
{
  users.users."${username}".packages = [
    pkgs.unstable.aerospace
  ];

  home-manager.users.${username} = {
    home.file."./.aerospace.toml".source = ./aerospace.toml;
  };
}

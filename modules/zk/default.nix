{ username, pkgs, ... }:

{
  users.users."${username}".packages = [
    pkgs.zk
    pkgs.fzf
  ];
  home-manager.users.${username} = {
    home.file."./.config/zk/config.toml".source = ./config.toml;
  };
}

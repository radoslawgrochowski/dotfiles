{ username, pkgs, ... }:
{
  imports = [
    ./common.nix
    ./nixos.nix
    ./terminal.nix
  ];

  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      xclip
    ];
  };

  boot.kernel.sysctl = {
    "fs.inotify.max_user_watches" = 1048576;
    "fs.inotify.max_user_instances" = 1024;
    "fs.inotify.max_queued_events" = 32768;
  };
}

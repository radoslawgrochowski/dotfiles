{ username, lib, pkgs,  ... }:

{
  home-manager.users.${username} = {
    systemd.user.startServices = true;
    systemd.user.timers.wallpapers-sync = {
      Unit = {
        Description = "Run wallpapers-sync.service periodically";
      };
      Timer = {
        OnBootSec = "5m";
        OnUnitActiveSec = "5m";
        Unit = "wallpapers-sync.service";
      };
      Install = {
        WantedBy = [ "timers.target" ];
      };
    };

    systemd.user.services.wallpapers-sync = {
      Install = {
        WantedBy = [ "default.target" ];
      };

      Unit = {
        Description = "Update wallpapers repositiory";
        Wants = [
          "network-online.target"
        ];
        After = [
          "network.target"
          "network-online.target"
        ];
      };

      Service = {
        Type = "oneshot";
        ExecStart = "${pkgs.bash}/bin/bash ${./wallpapers-sync.sh}";
        Environment = [
          "PATH=${lib.makeBinPath (with pkgs; [ openssh git ])}"
        ];
        RemainAfterExit = true;
        Restart = "on-failure";
        RestartSec = 600;
      };
    };
  };
}

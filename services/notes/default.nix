{ config, lib, pkgs, inputs, ... }:

{
  systemd.user.services.notes = {
    Install = {
      WantedBy = [ "default.target" ];
    };

    Unit = {
      Description = "Update notes repositiory";
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
      ExecStart = "${pkgs.bash}/bin/bash ${./notes.sh}";
      Environment = [
        "PATH=${lib.makeBinPath (with pkgs; [ openssh git ])}"
      ];
      RemainAfterExit = true;
      Restart = "on-failure";
      RestartSec = 600;
    };
  };
}

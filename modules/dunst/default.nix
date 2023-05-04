{ pkgs, username, ... }:

{
  home-manager.users.${username} = {
    home.packages = [ pkgs.dunst pkgs.pulseaudio ];
    services.dunst = {
      enable = true;
      settings = {
        play_sound = {
          summary = "*";
          script = toString (
            pkgs.writeShellScript "play_sound" ''
              ${pkgs.pulseaudio}/bin/paplay ${toString (./notification.wav)}
            ''
          );
        };
      };
    };
  };
}

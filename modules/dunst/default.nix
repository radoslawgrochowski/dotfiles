{ pkgs, username, ... }:

{
  home-manager.users.${username} = {
    home.packages = [ pkgs.dunst pkgs.pulseaudio ];
    services.dunst = {
      enable = true;
      settings = {
        global = {
          enable_posix_regex = true;
        };
        play_sound = {
          # http://www.formauri.es/personal/pgimeno/misc/non-match-regex/?word=Spotify
          appname = "^([^S]|S(S|p(S|o(S|t(S|i(S|fS)))))*([^Sp]|p([^So]|o([^St]|t([^Si]|i([^Sf]|f[^Sy]))))))*(S(S|p(S|o(S|t(S|i(S|fS)))))*(p(o?|ot(i?|if)))?)?$";
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

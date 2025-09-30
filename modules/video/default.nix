{ pkgs, username, ... }:
let
  ffmpeg-nice = pkgs.writeShellApplication {
    name = "ffmpeg-nice";
    runtimeInputs = [ pkgs.ffmpeg-full ];
    text = # shell
      ''
        set -o xtrace
        output="''${1%.*}_NICE.mp4"
        ffmpeg \
          -i "$1" \
          -n \
          -c:v libx265 \
          -crf 20 \
          -preset slow \
          -c:a aac -b:a 192k \
          -maxrate 4000k -bufsize 8000k \
          -movflags use_metadata_tags+faststart \
          -map_metadata 0 \
          "$output"
      '';
  };
in
{
  users.users."${username}".packages = [
    pkgs.ffmpeg-full
    ffmpeg-nice
  ];
}

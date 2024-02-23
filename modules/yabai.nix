{ pkgs, ... }:
let
  package = pkgs.unstable.yabai;
  yabai = "${package}/bin/yabai";
in
{
  # source = https://github.com/LnL7/nix-darwin/blob/master/modules/services/yabai/default.nix
  services.yabai = {
    enable = true;
    package = package;
    config = {
      layout = "bsp";
      focus_follows_mouse = "autofocus";
      mouse_follows_focus = "on";
      window_placement = "second_child";
      window_opacity = "off";
      top_padding = 8;
      bottom_padding = 8;
      left_padding = 8;
      right_padding = 8;
      window_gap = 8;

      split_ratio = "0.6";

      mouse_modifier = "cmd";
      mouse_action1 = "move";
      mouse_action2 = "resize";
      mouse_drop_action = "swap";
    };
    extraConfig =
      '' 
        yabai -m rule --add app="^System Settings$" manage=off
        yabai -m rule --add app="^Calculator$" manage=off
      ''
      + # https://github.com/koekeishiya/yabai/issues/1012#issuecomment-922885932
      ''
        yabai -m signal --add event=window_destroyed action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus recent || yabai -m window --focus first"
        yabai -m signal --add event=application_terminated action="yabai -m query --windows --window &> /dev/null || yabai -m window --focus recent || yabai -m window --focus first"
      ''
    ;
  };

  # TODO: swap hyper to use right modifiers so I can combo it with left modifiers e.g. for 
  # moving windows to other spaces
  services.skhd = {
    enable = true;
    skhdConfig = '' 
      hyper - h : ${yabai} -m window --focus west || ${yabai} -m display --focus west
      hyper - j : ${yabai} -m window --focus south || ${yabai} -m display --focus south
      hyper - k : ${yabai} -m window --focus north || ${yabai} -m display --focus north
      hyper - l : ${yabai} -m window --focus east || ${yabai} -m display --focus east
      hyper - f : ${yabai} -m window --toggle zoom-fullscreen
      hyper - q : ${yabai} -m window --close
      shift + hyper - h : ${yabai} -m window --swap west 
      shift + hyper - j : ${yabai} -m window --swap south 
      shift + hyper - k : ${yabai} -m window --swap north 
      shift + hyper - l : ${yabai} -m window --swap east 
    '';
  };

  launchd.user.agents.yabai.serviceConfig = {
    ProcessType = "Interactive";
    StandardOutPath = "/tmp/yabai.log";
    StandardErrorPath = "/tmp/yabai.log";
  };

  system.defaults.CustomUserPreferences = {
    "com.apple.dock" = {
      # Automatically rearrange Spaces based on most recent use -> [ ]
      mru-spaces = 0;
    };
    "com.apple.WindowManager" = {
      # Show Items -> On Desktop -> [x]
      StandardHideDesktopIcons = 0;
      # Click wallpaper to reveal Desktop -> Only in Stage Manager
      EnableStandardClickToShowDesktop = 0;
    };
  };
}

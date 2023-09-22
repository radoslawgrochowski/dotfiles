{ pkgs, username, ... }:

{
  home-manager.users.${username}.wayland.windowManager.hyprland = {
    extraConfig = ''
      monitor = HDMI-A-2, 1920x1080, 0x0, 1
      monitor = DP-2, 1920x1080@144, 1920x0, 1

      workspace = 1, monitor:HDMI-A-2
      workspace = 2, monitor:HDMI-A-2
      workspace = 3, monitor:HDMI-A-2
      workspace = 4, monitor:HDMI-A-2
      workspace = 5, monitor:HDMI-A-2
      workspace = 6, monitor:DP-2
      workspace = 7, monitor:DP-2
      workspace = 8, monitor:DP-2
      workspace = 9, monitor:DP-2
      workspace = 0, monitor:DP-2, default:true
    '';
  };
}

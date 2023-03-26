{ inputs, ... }:
{
  imports = [ inputs.hyprland.nixosModules.default ];

  nixpkgs.overlays = [
      (import ./overlays/waybar.nix)
  ];

  programs.xwayland.enable = true;
  services.xserver.displayManager.gdm.wayland = true;
  hardware.opengl.enable = true;
  programs.hyprland = {
    enable = true;
    nvidiaPatches = true;
  };
  users.groups.input.members = [ "radoslawgrochowski" ];
}

{ inputs, ... }:
{
  imports = [ inputs.hyprland.nixosModules.default ];

  nixpkgs.overlays = [
    (self: super: {
      waybar = super.waybar.overrideAttrs (oldAttrs: {
        mesonFlags = oldAttrs.mesonFlags ++ [ "-Dexperimental=true" ];
      });
    })
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

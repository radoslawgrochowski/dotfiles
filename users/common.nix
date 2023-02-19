{ config, pkgs, inputs, ... }:

{
  imports = [
    ../programs
    ../services
    ../fonts.nix
  ];
  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    arandr
    bat
    btop
    fd
    feh
    fzf
    google-chrome
    google-drive-ocamlfuse
    i3lock
    jc
    jq
    keepassxc
    kitty
    nixos-option
    nodePackages.pnpm
    nodePackages.typescript
    nodejs
    shutter
    spotifywm
    vlc
    xcwd
  ];

  systemd.user.startServices = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.stateVersion = "22.11";
}

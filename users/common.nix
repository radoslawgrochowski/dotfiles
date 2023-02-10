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
    xcwd
  ];

  systemd.user.startServices = true;

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file."scripts".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/scripts";
  home.stateVersion = "22.11";
}

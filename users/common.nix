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
    maim
    spotifywm
    unzip
    vlc
    xclip
    xcwd
  ];

  systemd.user.startServices = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/markdown" = "google-chrome.desktop";
      "text/html" = "google-chrome.desktop";
      "x-scheme-handler/http" = "google-chrome.desktop";
      "x-scheme-handler/https" = "google-chrome.desktop";
      "x-scheme-handler/about" = "google-chrome.desktop";
      "x-scheme-handler/unknown" = "google-chrome.desktop";
    };
  };

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.stateVersion = "22.11";
}

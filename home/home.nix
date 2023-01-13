{ config, pkgs, inputs, ... }:

{
  imports = [
    ../nvim/nvim.nix
    ./autorandr.nix
    ./bspwm.nix
    ./fish.nix
    ./fonts.nix
    ./git.nix
    ./kitty.nix
    ./picom.nix
    ./polybar.nix
    ./rofi.nix
    ./scripts.nix
    ./sxkhd.nix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bat
    btop
    fd
    feh
    fzf
    google-chrome
    google-drive-ocamlfuse
    i3lock
    jq
    keepassxc
    kitty
    nodejs
    nodePackages.typescript
    shutter
    spotify
    steam-run
    xcwd
  ];

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file."./.fdignore".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/fd/.fdignore";

  home.stateVersion = "22.11";
}

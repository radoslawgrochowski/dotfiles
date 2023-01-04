{ config, pkgs, inputs, ... }:

{
  imports = [
    ./autorandr.nix
    ./fish.nix
    ./fonts.nix
    ./git.nix
    ./i3.nix
    ./kitty.nix
    ./nvim.nix
    ./picom.nix
    ./polybar.nix
    ./rofi.nix
    ./scripts.nix
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    bat
    btop 
    fd
    fzf  
    google-drive-ocamlfuse
    jq
    keepassxc
    shutter
    spotify
    xcwd
    steam-run
  ];

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file."./.fdignore".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/fd/.fdignore";

  home.stateVersion = "22.11";
}

{ config, pkgs, inputs, ... }:

{
  imports = [
    ./programs
    ./services
    ./fonts.nix
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
    jq
    keepassxc
    kitty
    nodePackages.typescript
    nodejs
    shutter
    spotify
    steam-run
    xcwd
    haskellPackages.ghc
  ];

  programs.nix-index = {
    enable = true;
    enableFishIntegration = true;
  };

  home.file."scripts".source = config.lib.file.mkOutOfStoreSymlink "${inputs.self}/scripts";

  home.stateVersion = "22.11";
}
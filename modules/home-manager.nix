{ inputs, username, pkgs, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
    inherit username;
  };

  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      comma
      #    arandr
      #    bat
      btop
      #    fd
      #    feh
      #    fzf
      #    google-chrome
      #    google-drive-ocamlfuse
      #    i3lock
      #    jc
      jq
      #    keepassxc
      #    kooha
      #    nixos-option
      #    nodePackages.pnpm 
      #    nodePackages.typescript
      #    nodejs
      #    pavucontrol
      #    polkit
      #    polkit-kde-agent
      ranger
      #    spotifywm
      #    tldr
      #    unzip
      #    vlc
    ];

    systemd.user.startServices = true;

    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    home.stateVersion = "23.11";
  };
}

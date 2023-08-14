{ inputs, username, pkgs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  # for udiskie
  services.udisks2.enable = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
    inherit username;
  };

  home-manager.users.${username} = {
    imports = [
      inputs.hyprland.homeManagerModules.default
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
      kooha
      nixos-option
      nodePackages.pnpm 
      nodePackages.typescript
      nodejs
      pavucontrol
      polkit
      polkit-kde-agent
      ranger
      spotifywm
      unzip
      vlc
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
  };
}

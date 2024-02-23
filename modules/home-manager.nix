{ inputs, username, ... }:
{
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  home-manager.extraSpecialArgs = {
    inherit inputs;
    inherit username;
  };

  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    systemd.user.startServices = true;

    programs.nix-index = {
      enable = true;
      enableFishIntegration = true;
    };

    home.stateVersion = "23.11";
  };
}

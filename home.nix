{ inputs, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
  ];
  home-manager.useGlobalPkgs = true;
  home-manager.useUserPackages = true;
  # for udiskie
  services.udisks2.enable = true;
  home-manager.extraSpecialArgs = { inherit inputs; };
}

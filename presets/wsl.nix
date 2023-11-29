{ inputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../modules/locale.nix
    ../modules/home-manager.nix
    ../modules/git
  ];
}

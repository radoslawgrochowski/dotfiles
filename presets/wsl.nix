{ inputs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../modules/home-manager.nix

    ../modules/locale.nix
    ./terminal.nix
  ];
}

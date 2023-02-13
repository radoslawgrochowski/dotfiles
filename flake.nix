{
  description = "radoslawgrochowski workstation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    config-wp.url =
      "git+ssh://git@github.com/radoslawgrochowski/nixos-config-wp.git";
  };

  outputs = inputs@{ nixpkgs, home-manager, config-wp, agenix, ... }: {
    nixosConfigurations = {
      radoslawgrochowski-desktop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nix/configuration.nix
          ./nix/targets/desktop/hardware-configuration.nix
          ./nix/targets/desktop/target.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.radoslawgrochowski = import ./users/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          ./services/samba.nix
        ];
        specialArgs = { inherit inputs; };
      };

      radoslawgrochowski-hp = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nix/configuration.nix
          ./nix/targets/hp/hardware-configuration.nix
          ./nix/targets/hp/target.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.radoslawgrochowski = import ./users/home.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
        ];
        specialArgs = { inherit inputs; };
      };

      radoslawgrochowski-dell = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./nix/configuration.nix
          ./nix/targets/dell/hardware-configuration.nix
          ./nix/targets/dell/target.nix
          home-manager.nixosModules.home-manager
          {
            nixpkgs.overlays = [
              (final: prev: {
                nodejs = prev.nodejs-16_x;
              })
            ];
          }
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.radoslawgrochowski = import ./users/work.nix;
            home-manager.extraSpecialArgs = { inherit inputs; };
          }
          config-wp.nixosModules.wp
          agenix.nixosModules.age
          { age.identityPaths = [ "/home/radoslawgrochowski/.ssh/id_ed25519" ]; }
          { boot.kernelModules = [ "tun" "ipv6" ]; }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}

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
    hyprland.url = "github:hyprwm/Hyprland";
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
  };

  outputs = inputs@{ nixpkgs, home-manager, config-wp, agenix, hyprland, ... }:
    let
      overlays = [ inputs.neovim-nightly-overlay.overlay ];
    in
    {
      nixosConfigurations = {
        radoslawgrochowski-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./configuration.nix
            ./hosts/desktop
            ./home.nix
            { home-manager.users.radoslawgrochowski = import ./profiles/home.nix; }
            ./hyprland.nix
            ./services/samba.nix
            ./services/printing.nix
            ./docker.nix
          ];
          specialArgs = { inherit inputs; };
        };

        radoslawgrochowski-hp = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./configuration.nix
            ./hosts/hp
            ./home.nix
            { home-manager.users.radoslawgrochowski = import ./profiles/home.nix; }
            ./hyprland.nix
          ];
          specialArgs = { inherit inputs; };
        };

        radoslawgrochowski-dell = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./configuration.nix
            ./hosts/dell
            home-manager.nixosModules.home-manager
            {
              nixpkgs.overlays = [ (import ./overlays/node_16.nix) ];
            }
            ./home.nix
            ./hyprland.nix
            {
              home-manager.users.radoslawgrochowski = import ./profiles/work.nix;
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

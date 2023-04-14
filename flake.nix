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
      overlays = [ /* inputs.neovim-nightly-overlay.overlay */ ];
      username = "radoslawgrochowski";
    in
    {
      nixosConfigurations = {
        radoslawgrochowski-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./configuration.nix
            ./hosts/desktop
            ./profiles/home.nix

            ./modules/docker.nix
            ./modules/steam
            ./modules/printing.nix
            ./modules/samba.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit username;
          };
        };

        radoslawgrochowski-hp = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./configuration.nix
            ./hosts/hp
            ./profiles/home.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit username;
          };
        };

        radoslawgrochowski-dell = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./configuration.nix
            ./hosts/dell
            ./profiles/work.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit username;
          };
        };
      };
    };
}

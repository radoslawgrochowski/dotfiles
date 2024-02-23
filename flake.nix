# TODO: remove my username from hostnames
{
  description = "radoslawgrochowski workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.11";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs =
    inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, nixpkgs-stable, home-manager, ... }:
    let
      inherit (self) outputs inputs;
      lib = nixpkgs.lib;
      # merge it with configuration.nix
      commonModules = [
        ./modules/fonts.nix
        ./modules/nix.nix
        ({ overlays, ... }: { nixpkgs.overlays = overlays; })
      ];
      commonSpecialArgs = {
        inherit outputs;
        inherit inputs;
        overlays = lib.attrValues outputs.overlays;
        username = "radoslawgrochowski";
      };
    in
    {
      darwinConfigurations = {
        macaron = nix-darwin.lib.darwinSystem {
          system = "aarch64-darwin";
          modules = commonModules ++ [
            {
              nixpkgs.hostPlatform = "aarch64-darwin";
              nix.settings.extra-platforms = [ "aarch64-darwin" "x86_64-darwin" ];
            }
            ./hosts/macaron
            ./presets/darwin.nix
            ./presets/work.nix
            ./modules/spotify
          ];

          specialArgs = lib.attrsets.mergeAttrsList [
            commonSpecialArgs
            { username = "radoslaw.grochowski"; }
          ];
        };
      };

      overlays = (import ./overlays { inherit inputs; });

      darwinPackages = lib.lists.flatten map (c: c.pkgs) self.darwinConfigurations;

      nixosConfigurations = {
        radoslawgrochowski-wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = commonModules ++ [
            ./hosts/wsl
            ./presets/wsl.nix
            ./presets/nixos.nix
            ./presets/terminal.nix
          ];
          specialArgs = commonSpecialArgs;
        };
      };
    };
}

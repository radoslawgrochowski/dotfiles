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
      inputs.nixpkgs.follows = "nixpkgs-unstable";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-23.11";
      inputs.nixpkgs.follows = "nixpkgs-stable";
    };
  };

  outputs =
    inputs@{ self, nix-darwin, nixpkgs, nixpkgs-unstable, nixpkgs-stable, home-manager, ... }:
    let
      inherit (self) outputs;
      lib = nixpkgs.lib;
      # merge it with configuration.nix
      commonModules = [
        ./modules/fonts.nix
        ({ username, ... }: {
          # Auto upgrade nix package and the daemon service.
          services.nix-daemon.enable = true;

          nix = {
            registry.nixpkgs.flake = nixpkgs-stable;
            settings = {
              experimental-features = "nix-command flakes";
              trusted-users = [ "@admin" "${username}" ];
            };
            gc = {
              user = "root";
              automatic = true;
              interval = { Weekday = 0; Hour = 2; Minute = 0; };
              options = "--delete-older-than 30d";
            };
          };
        })
        ({ overlays, ... }: { nixpkgs.overlays = overlays; })
        ({ pkgs, username, ... }: {
          users.users."${username}".name = username;
        })
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
              # The platform the configuration will be used on.
              nixpkgs.hostPlatform = "aarch64-darwin";
              nix.settings.extra-platforms = [ "aarch64-darwin" "x86_64-darwin" ];
            }
            ./hosts/macaron
            ./presets/darwin.nix
            ./presets/work.nix

            # for lsps for nvim
            ({ pkgs, username, ... }: {
              home-manager.users."${username}".home.packages = [
                pkgs.cargo
                pkgs.rustc
              ];
            })

            # spotify
            # ({ pkgs, username, ... }: {
            #   nixpkgs.config.allowUnfree = true;
            #   home-manager.users."${username}".home.packages = [
            #     pkgs.spotify
            #   ];
            # })
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
        radoslawgrochowski-desktop = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            ./configuration.nix
            ./presets/nixos.nix
            ./hosts/desktop
            inputs.home-manager.nixosModules.home-manager
            ./profiles/home.nix

            ./modules/docker.nix
            ./modules/virtualbox.nix
            ./modules/steam
            ./modules/path-of-exile
            ./modules/printing.nix
            ./modules/samba.nix
          ];
          specialArgs = commonSpecialArgs;
        };

        radoslawgrochowski-hp = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            inputs.home-manager.nixosModules.home-manager
            ./configuration.nix
            ./presets/nixos.nix
            ./hosts/hp
            ./profiles/home.nix
          ];
          specialArgs = commonSpecialArgs;
        };
      };
    };
}

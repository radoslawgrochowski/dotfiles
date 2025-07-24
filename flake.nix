# TODO: remove my username from hostnames
{
  description = "radoslawgrochowski workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-25.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{ self
    , nix-darwin
    , nixpkgs
    , nixpkgs-unstable
    , flake-utils
    , ...
    }:
    let
      inherit (self) outputs inputs;
      lib = nixpkgs.lib;
      commonModules = [
        ({ overlays, ... }: { nixpkgs.overlays = overlays; })
      ];
      neovim-overlay = import ./modules/nvim/overlay.nix { inherit inputs; };
      overlays = (lib.attrValues outputs.overlays) ++ [
        neovim-overlay
        (self: super: {
          karabiner-elements = super.karabiner-elements.overrideAttrs (old: {
            version = "14.13.0";

            src = super.fetchurl {
              inherit (old.src) url;
              hash = "sha256-gmJwoht/Tfm5qMecmq1N6PSAIfWOqsvuHU8VDJY8bLw=";
            };
          });
        })
      ];
      commonSpecialArgs = {
        inherit outputs;
        inherit inputs;
        inherit overlays;
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
              nix.settings.system = "aarch64-darwin";
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

      # Expose the package set, including overlays, for convenience.
      darwinPackages = builtins.mapAttrs (hostname: config: config.pkgs) self.darwinConfigurations;

      nixosConfigurations = {
        radoslawgrochowski-wsl = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = commonModules ++ [
            ./hosts/wsl
            ./presets/wsl.nix
            ./modules/docker
            ./modules/video
            ./modules/aider
          ];
          specialArgs = commonSpecialArgs;
        };
      };
    } // flake-utils.lib.eachDefaultSystem
      (system:
      let
        pkgs = import nixpkgs { inherit system overlays; };
      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            just
            node2nix
            update-nix-fetchgit
            fd
          ];
          shellHook = ''
            # symlink the .luarc.json generated in the overlay
            ln -fs ${pkgs.nvim-luarc-json} .luarc.json
          '';
        };
        packages = { nvim-rg = pkgs.nvim-rg; };
      });

  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      "https://cache.nixos.org"
      "https://radoslawgrochowski-dotfiles.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "radoslawgrochowski-dotfiles.cachix.org-1:H4HOTwe9bPc+P2z/RVW3E8yBN6MwzRA4Xhv9RDpVu8c="
    ];
  };
}

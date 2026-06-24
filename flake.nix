{
  description = "radoslawgrochowski workstation configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-26.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-master.url = "github:nixos/nixpkgs/master";
    nix-darwin = {
      url = "github:LnL7/nix-darwin/nix-darwin-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    flake-utils.url = "github:numtide/flake-utils";
    nix-index-database = {
      url = "github:nix-community/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nix-darwin,
      nixpkgs,
      nixpkgs-unstable,
      nixpkgs-master,
      flake-utils,
      ...
    }:
    let
      inherit (self) outputs inputs;
      hosts = import ./hosts { inherit outputs inputs; };
    in
    {
      darwinConfigurations = hosts.darwinConfigurations;
      nixosConfigurations = hosts.nixosConfigurations;
      overlays = (import ./overlays { inherit inputs; });
    }
    // flake-utils.lib.eachDefaultSystem (
      system:
      let
        pkgs = import nixpkgs {
          inherit system;
          overlays = (nixpkgs.lib.attrValues outputs.overlays) ++ import ./modules/nvim/overlays.nix;
          config.allowUnfreePredicate =
            pkg:
            builtins.elem (nixpkgs.lib.getName pkg) [
              "vim-fubitive"
              "nvim-vtsls"
            ];
        };

      in
      {
        devShells.default = pkgs.mkShell {
          packages = with pkgs; [
            fd
            just
            nixfmt
            update-nix-fetchgit
            zizmor
          ];
          shellHook = ''
            # symlink the .luarc.json generated in the overlay
            ln -fs ${pkgs.nvim-luarc-json} .luarc.json
          '';
        };
        packages = {
          nvim-rg = pkgs.nvim-rg;
        };

        formatter = pkgs.nixfmt;
      }
    );

  nixConfig = {
    experimental-features = [
      "nix-command"
      "flakes"
    ];
    extra-substituters = [
      "https://cache.nixos.org"
      "https://nix-community.cachix.org"
      "https://radoslawgrochowski-dotfiles.cachix.org"
    ];
    extra-trusted-public-keys = [
      "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "radoslawgrochowski-dotfiles.cachix.org-1:H4HOTwe9bPc+P2z/RVW3E8yBN6MwzRA4Xhv9RDpVu8c="
    ];
  };
}

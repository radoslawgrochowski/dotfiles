{
  description = "radoslawgrochowski workstation";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-22.11";
    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    agenix.url = "github:ryantm/agenix";
    agenix.inputs.nixpkgs.follows = "nixpkgs";
    config-wp.url =
      "git+ssh://git@github.com/radoslawgrochowski/nixos-config-wp.git";
    hyprland.url = "github:hyprwm/Hyprland";
    other-nvim = {
      url = "github:rgroli/other.nvim";
      flake = false;
    };
  };

  outputs =
    inputs@{ nixpkgs
    , nixpkgs-stable
    , home-manager
    , config-wp
    , agenix
    , hyprland
    , ...
    }:
    let
      # vim-plugins = import ./overlays/vim-plugins.nix;

      # FIXME: Can I move this to ./overlays/ ?
      overlays = [
        (self: super:
          let
            other-nvim = super.vimUtils.buildVimPlugin {
              name = "other-nvim";
              src = inputs.other-nvim;
            };
          in
          {
            vimPlugins =
              super.vimPlugins // {
                inherit other-nvim;
              };
          }
        )
      ];
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
            ./modules/virtualbox.nix
            ./modules/steam
            ./modules/printing.nix
            ./modules/samba.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit username;
            pkgs-stable = nixpkgs-stable.legacyPackages."x86_64-linux";
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
            pkgs-stable = nixpkgs-stable.legacyPackages."x86_64-linux";
          };
        };

        radoslawgrochowski-dell = nixpkgs.lib.nixosSystem {
          system = "x86_64-linux";
          modules = [
            { nixpkgs.overlays = overlays; }
            ./configuration.nix
            ./hosts/dell
            ./profiles/work.nix

            ./modules/docker.nix
          ];
          specialArgs = {
            inherit inputs;
            inherit username;
            pkgs-stable = nixpkgs-stable.legacyPackages."x86_64-linux";
          };
        };
      };
    };
}

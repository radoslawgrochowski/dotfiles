{
  inputs,
  outputs,
  ...
}:
let
  username = "radoslawgrochowski";
in
(inputs.nixpkgs.lib.nixosSystem {
  system = "x86_64-linux";
  modules = [
    (
      { pkgs, ... }:
      {
        nixpkgs.overlays = (inputs.nixpkgs.lib.attrValues outputs.overlays);
        imports = [
          inputs.nixos-wsl.nixosModules.wsl
          inputs.home-manager.nixosModules.home-manager
          inputs.nix-index-database.nixosModules.nix-index
          ../../modules/home-manager
          ../../modules/fonts
          ../../modules/nix
          ../../modules/locale
          ../../modules/claude
          ../../modules/direnv
          ../../modules/fish
          ../../modules/git
          ../../modules/jujutsu
          ../../modules/kitty
          ../../modules/nvim
          ../../modules/opencode
          ../../modules/unfree
          ../../modules/zk
          ../../modules/docker
          ../../modules/video
          ../../modules/tailscale
        ];
        networking.hostName = "radoslawgrochowski-wsl";
        programs.nix-index-database.comma.enable = true;
        users.users."${username}" = {
          name = username;
          home = "/home/${username}/";
          extraGroups = [ "wheel" ];
          isNormalUser = true;
          description = username;
          packages = with pkgs; [
            btop
            gh
            jc
            jq
            nix-search-cli
            ranger
            ripgrep
            tldr
          ];
        };
        wsl.enable = true;
        wsl.defaultUser = "radoslawgrochowski";

        home-manager.users.${username} = {
          programs.home-manager.enable = true;
          home.packages = with pkgs; [ xclip ];
        };

        boot.kernel.sysctl = {
          "fs.inotify.max_user_watches" = 1048576;
          "fs.inotify.max_user_instances" = 1024;
          "fs.inotify.max_queued_events" = 32768;
        };

        system.stateVersion = "23.05";
      }
    )
  ];
  specialArgs = {
    inherit outputs inputs;
    inherit username;
  };
})

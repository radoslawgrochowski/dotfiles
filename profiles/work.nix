{ pkgs, username, inputs, ... }:

{
  imports = [
    inputs.config-wp.nixosModules.wp
    inputs.agenix.nixosModules.age
  ];

  age.identityPaths = [ "/home/${username}/.ssh/id_ed25519" ];
  boot.kernelModules = [ "tun" "ipv6" ];
  nixpkgs.overlays = [ (import ../overlays/node_16.nix) ];

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      glibc
    ];
  };
}

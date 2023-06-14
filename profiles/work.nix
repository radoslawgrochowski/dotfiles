{ pkgs, username, inputs, ... }:

{
  imports = [
    inputs.config-wp.nixosModules.wp
    inputs.agenix.nixosModules.age
  ];

  age.identityPaths = [ "/home/${username}/.ssh/id_ed25519" ];
  boot.kernelModules = [ "tun" "ipv6" ];

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      glibc
    ];
  };

  networking.firewall = {
    enable = true;
    allowedUDPPortRanges = [
      { from = 3000; to = 4000; }
      { from = 8000; to = 9000; }
    ];
    allowedTCPPorts = [
      3100
      8081
    ];

  };
}

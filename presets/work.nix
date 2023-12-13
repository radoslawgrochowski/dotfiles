{ username, pkgs, ... }: {
  imports = [
    ../modules/custom_ca_cert.nix
    ./terminal.nix
  ];
}

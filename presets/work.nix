{ ... }: {
  imports = [
    ../modules/custom-ca-cert
    ./terminal.nix
    ../modules/claude
  ];
}

{ username, pkgs, ... }: {
  imports = [
    ../modules/custom-ca-cert
    ./terminal.nix
  ];

  users.users."${username}".packages = with pkgs; [
    localNodePackages."@anthropic-ai/claude-code"
  ];
}

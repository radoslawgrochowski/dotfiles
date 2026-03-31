{ username, pkgs, ... }:
{
  imports = [
    ./terminal.nix
    ../modules/custom-ca-cert
    ../modules/spotify
  ];

  users.users."${username}".packages = with pkgs; [
    jira-cli-go
    pkgs.master.worktrunk
  ];
}

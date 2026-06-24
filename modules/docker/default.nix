{ username, ... }:
{
  virtualisation.docker.enable = true;
  users.groups.docker.members = [ username ];
  # remove after 26.05 update
  nixpkgs.config.permittedInsecurePackages = [
    "docker-28.5.2"
  ];
}

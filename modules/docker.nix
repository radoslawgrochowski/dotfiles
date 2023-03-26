{ username, ... }:
{
  virtualisation.docker.enable = true;
  users.groups.docker.members = [ username ];
}

{ username, pkgs-stable, ... }:
{
  virtualisation.virtualbox.host = {
    enable = true;
  };
  users.extraGroups.vboxusers.members = [ username ];
}

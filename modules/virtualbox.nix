{ username, pkgs-stable, ... }:
{
  # virtualisation.virtualbox.host = {
  #   enable = true;
  #   # package = pkgs-stable.virtualbox;
  # };

  users.extraGroups.vboxusers.members = [ username ];

  # home-manager.users.${username} = {
  #   home.packages = with pkgs-stable; [
  #     vagrant
  #     remotebox
  #   ];
  # };
}

{ inputs, username, ... }:
{
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../modules/home-manager
    inputs.nix-index-database.nixosModules.nix-index
    ../modules/locale
  ];

  programs.nix-index-database.comma.enable = true;
  users.users."${username}" = {
    name = username;
    home = "/home/${username}/";
    extraGroups = [ "wheel" ];
    isNormalUser = true;
    description = username;
  };
}

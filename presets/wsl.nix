{ inputs, username, pkgs, ... }: {
  imports = [
    inputs.home-manager.nixosModules.home-manager
    ../modules/home-manager.nix

    ../modules/locale.nix
    ./terminal.nix
  ];

  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      xclip
    ];
  };
}

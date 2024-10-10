{ username, pkgs, ... }: {
  imports = [
    ./common.nix
    ./nixos.nix
    ./terminal.nix
  ];

  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      xclip
    ];
  };
}

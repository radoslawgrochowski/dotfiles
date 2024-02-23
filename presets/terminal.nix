{ username, pkgs, ... }: {
  imports = [
    ../modules/git
    ../modules/fish.nix
    ../modules/kitty
    ../modules/nvim
  ];

  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      btop
      comma
      jc
      jq
      ranger
      tldr
    ];
  };
}

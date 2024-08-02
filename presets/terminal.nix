{ username, pkgs, ... }: {
  imports = [
    ../modules/direnv
    ../modules/fish.nix
    ../modules/git
    ../modules/kitty
    ../modules/lazyvim
    ../modules/nvim
  ];

  home-manager.users.${username} = {
    programs.home-manager.enable = true;

    home.packages = with pkgs; [
      btop
      comma
      jc
      jq
      nix-search-cli
      ranger
      tldr
    ];
  };
}

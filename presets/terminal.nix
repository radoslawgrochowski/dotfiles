{ username, pkgs, ... }: {
  imports = [
    ../modules/direnv
    ../modules/fish
    ../modules/git
    ../modules/kitty
    ../modules/nvim
    ../modules/zk
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

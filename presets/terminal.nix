{ username, pkgs, ... }:
{
  imports = [
    ../modules/claude
    ../modules/direnv
    ../modules/fish
    ../modules/git
    ../modules/jujutsu
    ../modules/kitty
    ../modules/nvim
    ../modules/opencode
    ../modules/unfree
    ../modules/zk
  ];

  home-manager.users.${username} = {
    programs.home-manager.enable = true;
  };

  users.users."${username}".packages = with pkgs; [
    btop
    gh
    jc
    jq
    nix-search-cli
    ranger
    ripgrep
    tldr
  ];
}

{ username, pkgs, ... }:
{
  imports = [
    ../modules/unfree
    ../modules/direnv
    ../modules/fish
    ../modules/git
    ../modules/kitty
    ../modules/nvim
    ../modules/opencode
    ../modules/claude
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

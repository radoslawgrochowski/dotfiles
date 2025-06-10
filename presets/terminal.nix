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
  };

  users.users."${username}".packages = with pkgs;[
    pkgs.unstable.aider-chat-full
    btop
    jc
    jq
    nix-search-cli
    ranger
    tldr
  ];
}

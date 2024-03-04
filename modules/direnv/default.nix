{ username, pkgs, ... }: {

  home-manager.users.${username} = {
    home.packages = with pkgs; [
      direnv
      nix-direnv
    ];
    home.file."./.config/direnv/direnv.toml".source = ./direnv.toml;
  };
}

{ username, pkgs, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [ git git-machete git-lfs ];
    home.file."./.gitconfig".source = ./.gitconfig;
    home.file."./.gitignore".source = ./.gitignore;
  };
}

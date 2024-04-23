{ username, pkgs, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs.stable; [ git git-machete ];
    home.file."./.gitconfig".source = ./.gitconfig;
    home.file."./.gitignore".source = ./.gitignore;
  };
}

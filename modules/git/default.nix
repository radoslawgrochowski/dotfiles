{ username, pkgs, ... }:

{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      git
      (git-machete.overrideAttrs (old: {
        doCheck = false; # Skip tests - failing in Nix sandbox on macOS
      }))
      git-lfs
    ];
    home.file."./.gitconfig".source = ./.gitconfig;
    home.file."./.gitignore".source = ./.gitignore;
  };
}

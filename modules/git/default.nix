{ username, pkgs, ... }:

let
  clone-for-worktrees = pkgs.writeShellScriptBin "clone-for-worktrees" (
    builtins.readFile ./clone-for-worktrees.sh
  );
in
{
  home-manager.users.${username} = {
    home.packages = with pkgs; [
      git
      (git-machete.overridePythonAttrs (old: {
        doCheck = false; # Skip tests - failing in Nix sandbox on macOS
      }))
      git-lfs
      clone-for-worktrees
    ];
    home.file."./.gitconfig".source = ./.gitconfig;
    home.file."./.gitignore".source = ./.gitignore;
  };
}

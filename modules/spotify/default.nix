({ pkgs, lib, username, ... }: {
  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [
      "spotify"
    ];
  users.users.${username}.packages = [
    pkgs.spotify
  ];
})

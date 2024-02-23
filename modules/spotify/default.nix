({ pkgs, lib, username, ... }: {
  nixpkgs.config.allowUnfreePredicate =
    pkg: builtins.elem (lib.getName pkg) [
      "spotify"
    ];

  home-manager.users."${username}".home.packages = [
    pkgs.spotify
  ];
})

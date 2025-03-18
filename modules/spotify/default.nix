({ pkgs, username, ... }: {
  users.users.${username}.packages = [
    pkgs.spotify
  ];
})

{ username, pkgs, ... }: {
  users.users."${username}".packages = [
    pkgs.unstable.opencode
  ];
}

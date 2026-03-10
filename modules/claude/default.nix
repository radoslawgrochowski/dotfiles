(
  {
    pkgs,
    username,
    ...
  }:
  {
    my.unfreePackages = [ "claude-code" ];
    users.users.${username}.packages = [
      pkgs.unstable.claude-code
    ];
  }
)

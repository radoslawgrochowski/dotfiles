{
  config,
  username,
  pkgs,
  ...
}:
{
  services.aerospace = {
    package = pkgs.unstable.aerospace;
    enable = true;
    settings = builtins.fromTOML (builtins.readFile ./aerospace.toml);
  };

  users.users."${username}".packages = [
    config.services.aerospace.package
  ];
}

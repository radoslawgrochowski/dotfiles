{
  username,
  options,
  lib,
  ...
}:
{
  config = {
    users.groups.docker.members = [ username ];
  }
  // lib.optionalAttrs (builtins.hasAttr "virtualisation" options) {
    virtualisation.docker.enable = true;
  };
}

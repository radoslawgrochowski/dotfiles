{
  username,
  options,
  lib,
  ...
}:
{
  config = {
    users.groups.docker.members = [ username ];
    nixpkgs.config.permittedInsecurePackages = [
      "docker-28.5.2"
    ];
  }
  // lib.optionalAttrs (builtins.hasAttr "virtualisation" options) {
    virtualisation.docker.enable = true;
  };
}

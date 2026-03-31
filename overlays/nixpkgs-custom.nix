{ inputs, ... }:
{
  nixpkgsCustom = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      localSystem = final.stdenv.hostPlatform.system;
      config = final.config;
    };
    master = import inputs.nixpkgs-master {
      localSystem = final.stdenv.hostPlatform.system;
      config = final.config;
    };
  };
}

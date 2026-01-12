{ inputs, ... }:
{
  nixpkgsCustom = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      localSystem = final.stdenv.hostPlatform.system;
    };
  };
}

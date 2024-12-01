{ inputs, ... }:
{
  nixpkgsCustom = final: _prev: {
    unstable = import inputs.nixpkgs-unstable {
      system = final.system;
    };
    master = import inputs.nixpkgs-master {
      system = final.system;
    };
  };
}

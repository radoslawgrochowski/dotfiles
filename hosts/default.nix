params: {
  darwinConfigurations = {
    macaron = (import ./macaron params);
  };
  nixosConfigurations = {
    radoslawgrochowski-wsl = (import ./wsl params);
  };
}

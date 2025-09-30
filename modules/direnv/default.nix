{ ... }:
{
  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    nix-direnv = {
      enable = true;
    };
    # TODO: Update and enable shell integrations:
    # enableBashIntegration = true;
    # enableFishIntegration = true;
  };
}

{ inputs, username, ... }:
{
  programs.direnv = {
    enable = true;
    silent = true;
    loadInNixShell = true;
    nix-direnv = {
      enable = true;
    };

    # disable shell integrations in favour of direnv-instant ones
    enableBashIntegration = false;
    enableFishIntegration = false;
    enableZshIntegration = false;
  };

  home-manager.users.${username} = {
    imports = [ inputs.direnv-instant.homeModules.direnv-instant ];

    programs.direnv-instant.enable = true;
  };
}

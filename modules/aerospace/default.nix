# TODO: Consider making this module
# TODO: Rename to something more generic about darwin window/workflow management
{ username, pkgs, ... }:
let
  chooseApp = pkgs.writeShellApplication {
    name = "choose-app";
    runtimeInputs = [ ];
    text = /* bash */ ''
      # shellcheck disable=SC2010
      ls \
        /Applications/ \
        /Applications/Nix\ Apps/ \
        ~/Applications/ \
        ~/Applications/Home\ Manager\ Apps/ \
        /Applications/Utilities/ \
        /System/Applications/ \
        /System/Applications/Utilities/ \
        | \
          grep '\.app$' | \
          sed 's/\.app$//g' | \
          ${pkgs.choose-gui}/bin/choose | \
          xargs -I {} open -a "{}.app"
    '';
  };
in
{
  homebrew = {
    casks = [ "aerospace" ];
    taps = [ "nikitabobko/tap" ];
  };

  users.users."${username}".packages = [ chooseApp ];

  home-manager.users.${username} = {
    home.file."./.aerospace.toml".source = ./aerospace.toml;
  };
}

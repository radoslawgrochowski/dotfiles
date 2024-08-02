{ lib, username, pkgs, options, ... }:
{
  config =
    let
      lazyvim = (pkgs.unstable.neovim.override {
        extraPython3Packages = (p: with p;[
          python-dotenv
          requests
          pkgs.unstable.python311Packages.pynvim
          prompt-toolkit
        ]);
      });
    in
    {
      home-manager.users.${username} = {
        home.packages = with pkgs;
          [
            clang
            cargo
            rustc
            ripgrep
          ];

        home.file."./.config/nvim/" = {
          source = ./config;
          recursive = true;
        };
        programs.fish.shellAliases = {
          lazyvim = "${lazyvim}/bin/nvim";
        };
      };
    } // lib.optionalAttrs (builtins.hasAttr "homebrew" options) {
      # needed for spectre plugin on darwin
      homebrew.brews = [ "gnu-sed" ];
    };
}

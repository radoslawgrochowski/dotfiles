{ config, lib, username, pkgs, options, ... }:
{
  config = {
    home-manager.users.${username} = {
      home.packages = with pkgs;[
        (unstable.neovim.override {
          extraPython3Packages = (p: with p;[
            python-dotenv
            requests
            pkgs.unstable.python311Packages.pynvim
            prompt-toolkit
          ]);
        })
        clang
        cargo
        rustc
        ripgrep
      ];

      home.file."./.config/nvim/" = {
        source = ./config;
        recursive = true;
      };
    };
  } // lib.optionalAttrs (builtins.hasAttr "homebrew" options) {
    # needed for spectre plugin on darwin
    homebrew.brews = [ "gnu-sed" ];
  };
}

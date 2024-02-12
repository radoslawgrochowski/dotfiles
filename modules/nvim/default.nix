{ username, pkgs, ... }:
{
  home-manager.users.${username} = {
    home.packages = [
      pkgs.neovim
      pkgs.cargo
      pkgs.rustc
      pkgs.ripgrep
    ];

    home.file."./.config/nvim/" = {
      source = ./config;
      recursive = true;
    };
  };

  homebrew.brews = [
    "gnu-sed" # needed for spectre plugin
  ];
}

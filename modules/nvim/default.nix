{ config, lib, username, pkgs, ... }:
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
      cargo
      rustc
      ripgrep
    ];

    home.file."./.config/nvim/" = {
      source = ./config;
      recursive = true;
    };
  };

  }# // (lib.mkIf (config.system == "darwin") {
   #  	# needed for spectre plugin
   #  	homebrew.brews = [ "gnu-sed" ]; 
   #     });
   # } 
   ;
}

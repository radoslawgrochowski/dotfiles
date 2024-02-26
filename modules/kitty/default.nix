{ username, pkgs, lib, config, options, ... }:
let
  package = pkgs.kitty;
  kitty = "${package}/bin/kitty";
  userHome = config.users.users."${username}".home;
  # TODO: move to notebook module
  notebookPath = "${userHome}/Projects/notebook";
in
{
  config = {
    home-manager.users.${username} = {
      home.packages = [ pkgs.kitty ];
      home.file."./.config/kitty/kitty.conf".source = ./kitty.conf;
    };
  } // lib.optionalAttrs (builtins.hasAttr "skhd" options.services) {
    services.skhd.skhdConfig = ''
      hyper - return : ${kitty} --single-instance -d ~
      hyper - n : ${kitty} --single-instance -T notebook -d ${notebookPath} nvim ${notebookPath}
    '';
  };
}

      

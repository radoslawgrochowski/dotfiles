({ pkgs, ... }:
  let
    package = pkgs.unstable.skhd;
    skhd = "${package}/bin/skhd";
  in
  {
    services.skhd = {
      enable = true;
      skhdConfig = '' 
      hyper - d : ${skhd} -k "cmd - space"
    '';
    };

    launchd.user.agents.skhd.serviceConfig = {
      # make skhd faster by ensuring it's not using fish
      EnvironmentVariables = {
        SHELL = "/bin/bash";
      };
      StandardOutPath = "/tmp/skhd.log";
      StandardErrorPath = "/tmp/skhd.log";
    };
  })

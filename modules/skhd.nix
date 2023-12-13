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
      ctrl - v [
        "Google Chrome" : ${skhd} -k "cmd - v"
      ]
      ctrl - c [
        "Google Chrome" : ${skhd} -k "cmd - c"
      ]
      ctrl - w [
        "Google Chrome" : ${skhd} -k "cmd - w"
      ]
      ctrl - t [
        "Google Chrome" : ${skhd} -k "cmd - t"
      ]
      ctrl + shift - t [
        "Google Chrome" : ${skhd} -k "cmd + shift - t"
      ]
      ctrl + shift - i [
        "Google Chrome" : ${skhd} -k "cmd + alt - i"
      ]
    '';
    };

    launchd.user.agents.skhd.serviceConfig = {
      # make skhd faster by ensuring it's not using fish
      EnvironmentVariables = {
        SHELL = "/bin/bash";
      };
    };
  })

{ pkgs, lib, username, ... }:

let
  unwrapped = pkgs.stdenv.mkDerivation {
    pname = "browserstacklocal";
    version = "2023-09-06";

    src = pkgs.fetchzip {
      url = "https://www.browserstack.com/browserstack-local/BrowserStackLocal-linux-x64.zip";
      sha256 = "sha256-w8D4ZDuM0T8gSMven74uPyqVCCqmvNGVQoOrynruDhQ=";
    };

    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      mkdir -p $out/bin
      mv BrowserStackLocal $out/bin/
      chmod +x $out/bin/BrowserStackLocal
    '';
  };
  browserstacklocal = pkgs.buildFHSUserEnv {
    name = "BrowserStackLocal";
    targetPkgs = pkgs: [ unwrapped ];
    runScript = "BrowserStackLocal";
  };
in
{
  home-manager.users.${username} = {
    home.packages = [
      browserstacklocal
    ];
  };
}

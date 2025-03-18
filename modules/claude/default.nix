{ pkgs, username, ... }:
let
  claudeCall = pkgs.callPackage (./claude.nix) { };
  claude = (claudeCall {
    additionalPkgs = with pkgs; [
      nodejs
      unstable.python313
      unstable.python313Packages.uv
    ];
  });
in
{
  nixpkgs.overlays = [ (final: prev: { inherit claude; }) ];
  users.users."${username}".packages = [
    pkgs.claude
  ];
  system.activationScripts.extraActivation.text = ''
    mkdir -p "/Applications"
    ln -sf ${pkgs.claude}/Applications/Claude.app "/Applications/Claude.app"
  '';
}


{ pkgs-stable, ... }:
{
  programs.gnupg = {
    package = pkgs-stable.gnupg;
    agent.enable = true;
  };
}

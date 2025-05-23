{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    nerd-fonts.blex-mono
    nerd-fonts.symbols-only
  ];
}


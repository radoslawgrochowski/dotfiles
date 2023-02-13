{ config, pkgs, inputs, ... }:

{
  home.packages = [
    (pkgs.nerdfonts.override {
      fonts = [
        "FiraCode"
        "FiraMono"
        "NerdFontsSymbolsOnly"
        "IBMPlexMono"
        "JetBrainsMono"
      ];
    })
  ];
  fonts.fontconfig.enable = true;
}


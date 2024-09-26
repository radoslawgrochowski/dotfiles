{ pkgs, ... }:
{
  fonts.packages = with pkgs; [
    (nerdfonts.override {
      fonts = [
        "NerdFontsSymbolsOnly"
        "IBMPlexMono"
      ];
    })
  ];
}


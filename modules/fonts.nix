{ username, pkgs, ... }:

{
  home-manager.users.${username} = {
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
  };
}


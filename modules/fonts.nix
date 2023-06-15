{ username, pkgs, ... }:

{
  home-manager.users.${username} = {
    home.packages = [
      (pkgs.nerdfonts.override {
        fonts = [
          "NerdFontsSymbolsOnly"
          "IBMPlexMono"
        ];
      })
    ];
    fonts.fontconfig.enable = true;
  };
}


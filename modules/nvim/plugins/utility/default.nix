{ pkgs }: {
  plugins = with pkgs.vimPlugins; [
    plenary-nvim
    which-key-nvim
    nvim-web-devicons
  ];
}


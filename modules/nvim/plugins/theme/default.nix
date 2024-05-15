{ pkgs }: {
  plugins = with pkgs.vimPlugins; [
    tokyonight-nvim
    telescope-nvim
  ];
  config = builtins.readFile ./config.lua;
}

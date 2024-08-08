{ pkgs }: {
  plugins = with pkgs.vimPlugins; [
    tokyonight-nvim
    telescope-nvim
    pkgs.localVimPlugins.markdown-nvim
  ];
  config = builtins.readFile ./config.lua;
}

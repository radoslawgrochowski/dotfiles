{ pkgs }: {
  plugins = with pkgs.vimPlugins; [
    tokyonight-nvim
  ];
  config = ''
    vim.cmd.colorscheme "tokyonight-night"
  '';
}

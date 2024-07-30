{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    nvim-cmp

    cmp-buffer
    cmp-cmdline
    cmp-emoji
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-path
    cmp-rg

    cmp-npm
  ];
  config = builtins.readFile ./config.lua;
} 

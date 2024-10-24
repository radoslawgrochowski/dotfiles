{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    nvim-cmp

    cmp-buffer
    cmp-cmdline
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-path

    cmp-rg
    pkgs.ripgrep
  ];

  config = builtins.readFile ./config.lua;
} 

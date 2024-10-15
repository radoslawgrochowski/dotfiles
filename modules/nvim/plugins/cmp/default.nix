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
    pkgs.ripgrep

    cmp-npm

    pkgs.localVimPlugins.supermaven-nvim
  ];
  config = builtins.readFile ./config.lua;
} 

{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    pkgs.localVimPlugins.nvim-cmp

    cmp-buffer
    cmp-cmdline
    cmp-nvim-lsp
    cmp-nvim-lsp-signature-help
    cmp-path

    cmp-rg
  ];

  extraPackages = with pkgs; [
    ripgrep
  ];

  config = builtins.readFile ./config.lua;
} 

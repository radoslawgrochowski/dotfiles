{ pkgs }:
{
  plugins = with pkgs.vimPlugins;
    [
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-treesitter.withAllGrammars
      nvim-ts-autotag
      nvim-ts-context-commentstring
    ];
  config = builtins.readFile ./config.lua;
} 

{ pkgs }:
{
  plugins = with pkgs.vimPlugins;
    [
      nvim-treesitter-context
      nvim-treesitter-textobjects
      nvim-ts-context-commentstring
      nvim-treesitter.withAllGrammars
    ];
  config = builtins.readFile ./config.lua;
} 

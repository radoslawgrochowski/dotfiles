{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    # dependencies
    nvim-nio
    plenary-nvim
    FixCursorHold-nvim

    neotest
    neotest-jest
  ];
  config = builtins.readFile ./config.lua;
} 

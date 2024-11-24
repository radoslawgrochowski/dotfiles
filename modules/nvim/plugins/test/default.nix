{ pkgs }:
let
  unstable = pkgs.unstable.vimPlugins;
in
{
  plugins = with pkgs.vimPlugins; [
    # dependencies
    nvim-nio
    plenary-nvim
    FixCursorHold-nvim

    unstable.neotest
    unstable.neotest-jest
  ];
  config = builtins.readFile ./config.lua;
} 

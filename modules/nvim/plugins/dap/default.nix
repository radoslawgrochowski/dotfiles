{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    nvim-nio
    nvim-dap
    nvim-dap-ui
  ];
  extraPackages = [
    pkgs.vscode-js-debug
  ];
  config = /* lua */''
    JS_DEBUG_PATH = '${"${pkgs.vscode-js-debug}"}/bin/js-debug';
    ${builtins.readFile ./config.lua}
  '';
} 


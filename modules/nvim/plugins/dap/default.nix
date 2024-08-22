{ pkgs }:
{
  plugins = with pkgs.vimPlugins; [
    nvim-nio
    nvim-dap
    nvim-dap-ui
  ];
  extraPackages = [
    pkgs.unstable.vscode-js-debug
  ];
  config = /* lua */''
    JS_DEBUG_PATH = '${"${pkgs.unstable.vscode-js-debug}"}/bin/js-debug';
    ${builtins.readFile ./config.lua}
  '';
} 


# Function for creating a Neovim derivation
{ pkgs, lib, stdenv }:
with lib;
{ plugins ? [ ]
, extraPackages ? [ ]
, # Additional lua packages (not plugins), e.g. from luarocks.org
  resolvedExtraLuaPackages ? [ ]
, extraPython3Packages ? p: [ ]
, withPython3 ? true
, withRuby ? false
, withNodeJs ? false
, withSqlite ? true
, viAlias ? true
, vimAlias ? true
, config
}:
let
  # This is the structure of a plugin definition.
  # Each plugin in the `plugins` argument list can also be defined as this attrset
  defaultPlugin = {
    plugin = null; # e.g. nvim-lspconfig
    config = null; # plugin config
    # If `optional` is set to `false`, the plugin is installed in the 'start' packpath
    # set to `true`, it is installed in the 'opt' packpath, and can be lazy loaded with
    # ':packadd! {plugin-name}
    optional = false;
    runtime = { };
  };

  externalPackages = extraPackages ++ (optionals withSqlite [ pkgs.sqlite ]);

  # Map all plugins to an attrset { plugin = <plugin>; config = <config>; optional = <tf>; ... }
  normalizedPlugins = map
    (x:
      defaultPlugin
      // (
        if x ? plugin
        then x
        else { plugin = x; }
      ))
    plugins;

  # This nixpkgs util function creates an attrset
  # that pkgs.wrapNeovimUnstable uses to configure the Neovim build.
  neovimConfig = pkgs.unstable.neovimUtils.makeNeovimConfig {
    inherit extraPython3Packages withPython3 withRuby withNodeJs viAlias vimAlias;
    plugins = normalizedPlugins;
  };

  # Add arguments to the Neovim wrapper script
  extraMakeWrapperArgs = builtins.concatStringsSep " " (
    # Add external packages to the PATH
    (optional (externalPackages != [ ])
      ''--prefix PATH : "${makeBinPath externalPackages}"'')
    # Set the LIBSQLITE_CLIB_PATH if sqlite is enabled
    ++ (optional withSqlite
      ''--set LIBSQLITE_CLIB_PATH "${pkgs.sqlite.out}/lib/libsqlite3.so"'')
    # Set the LIBSQLITE environment variable if sqlite is enabled
    ++ (optional withSqlite
      ''--set LIBSQLITE "${pkgs.sqlite.out}/lib/libsqlite3.so"'')
  );

  # Native Lua libraries
  extraMakeWrapperLuaCArgs = optionalString (resolvedExtraLuaPackages != [ ]) ''
    --suffix LUA_CPATH ";" "${
      lib.concatMapStringsSep ";" pkgs.luaPackages.getLuaCPath
      resolvedExtraLuaPackages
    }"'';

  # Lua libraries
  extraMakeWrapperLuaArgs =
    optionalString
      (resolvedExtraLuaPackages != [ ])
      ''
        --suffix LUA_PATH ";" "${
          concatMapStringsSep ";" pkgs.luaPackages.getLuaPath
          resolvedExtraLuaPackages
        }"'';
in
# wrapNeovimUnstable is the nixpkgs utility function for building a Neovim derivation.
pkgs.unstable.wrapNeovimUnstable
  pkgs.unstable.neovim-unwrapped
  (neovimConfig
    // {
    luaRcContent = config;
    wrapperArgs =
      escapeShellArgs neovimConfig.wrapperArgs
        + " "
        + extraMakeWrapperArgs
        + " "
        + extraMakeWrapperLuaCArgs
        + " "
        + extraMakeWrapperLuaArgs;
    #wrapRc = true;
  })

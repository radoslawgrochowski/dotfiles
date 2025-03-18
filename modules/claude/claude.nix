{ lib, stdenv, undmg, fetchurl, makeWrapper, writeScript }:

let
  # Original Claude app (no modifications)
  claudeApp = stdenv.mkDerivation {
    pname = "claude-app";
    version = "1.0.0";

    src = fetchurl {
      url = "https://storage.googleapis.com/osprey-downloads-c02f6a0d-347c-492b-a752-3e0651722e97/nest/Claude.dmg";
      sha256 = "0gy65izjmc0928algcilzpfxl1z6g9pdfkasxxyf3kqp21fcyk57";
    };

    nativeBuildInputs = [ undmg ];

    phases = [ "unpackPhase" "installPhase" ];

    sourceRoot = ".";

    unpackPhase = ''
      undmg "$src"
    '';

    installPhase = ''
      mkdir -p "$out/Applications"
      
      # Find and copy the .app bundle
      for app in *.app; do
        if [ -d "$app" ]; then
          cp -r "$app" "$out/Applications/"
        fi
      done
      
      if [ ! -d "$out/Applications" ] || [ -z "$(ls -A "$out/Applications")" ]; then
        echo "Error: Failed to install any application to $out/Applications"
        exit 1
      fi
    '';
  };

in
{ additionalPkgs ? [ ] }:

stdenv.mkDerivation {
  pname = "claude";
  version = claudeApp.version;

  buildInputs = [ makeWrapper ];

  # Skip unneeded phases
  phases = [ "installPhase" ];

  installPhase = ''
        # Create the wrapped app structure from scratch
        mkdir -p $out/Applications/Claude.app/Contents/MacOS
        mkdir -p $out/bin
    
        # Find the original app name and executable
        original_app=$(ls -1 ${claudeApp}/Applications | head -1)
        original_executable=$(ls -1 ${claudeApp}/Applications/$original_app/Contents/MacOS | head -1)
        original_exec_path="${claudeApp}/Applications/$original_app/Contents/MacOS/$original_executable"
    
        echo "Original app: $original_app"
        echo "Original executable: $original_executable"
        echo "Original exec path: $original_exec_path"
    
        # Copy all the app contents except the MacOS directory
        for dir in ${claudeApp}/Applications/$original_app/Contents/*; do
          dir_name=$(basename "$dir")
      
          if [ "$dir_name" != "MacOS" ]; then
            echo "Copying directory: $dir_name"
            cp -r "$dir" $out/Applications/Claude.app/Contents/
          fi
        done
    
        # Create our wrapper script as the new executable
        wrapper_path="$out/Applications/Claude.app/Contents/MacOS/$original_executable"
    
        cat > "$wrapper_path" << EOF
    #!/bin/bash

    # Set up the environment with all the additional packages
    export PATH="${lib.makeBinPath additionalPkgs}:\$PATH"

    # Launch the original executable from the Nix store
    exec "$original_exec_path" "\$@"
    EOF
    
        # Make the wrapper executable
        chmod +x "$wrapper_path"
    
        # Also create a command-line launcher in bin/
        makeWrapper "$wrapper_path" "$out/bin/claude"
    
        echo "Created wrapped application at $out/Applications/Claude.app"
        echo "Created wrapper script at $out/bin/claude"
  '';

  meta = {
    description = "Claude AI Chat Application with additional tools";
    homepage = "https://anthropic.com";
    license = lib.licenses.unfree;
    platforms = lib.platforms.darwin;
    mainProgram = "claude";
  };
}

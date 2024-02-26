os := `uname`

_default:
  just --list

update: 
  nix flake update

darwin-switch: && darwin-restart-skhd
  nix run nix-darwin -- switch --flake .

darwin-restart-skhd:
  launchctl stop org.nixos.skhd && launchctl start org.nixos.skhd

switch:
    @if [ "{{os}}" == "Darwin" ]; then \
        just darwin-switch; \
    else \
        echo "Unknown operating system"; \
    fi

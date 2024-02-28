os := `uname`

_default:
  just --list

update: 
  nix flake update

darwin-switch: && darwin-restart-skhd
  nix run nix-darwin -- switch --flake .#macaron

darwin-restart-skhd:
  launchctl stop org.nixos.skhd && launchctl start org.nixos.skhd

nixos-switch:
  sudo nixos-rebuild switch --flake .

switch:
  @if [ "{{os}}" == "Darwin" ]; then \
    just darwin-switch; \
  else \
    just nixos-switch; \
  fi

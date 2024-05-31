os := `uname`

_default:
  just --list

update: 
  nix flake update

darwin-switch: 
  nix run nix-darwin -- switch --flake .#macaron

nixos-switch:
  sudo nixos-rebuild switch --flake .

switch:
 @if [ "{{os}}" == "Darwin" ]; then \
   just darwin-switch; \
 else \
   just nixos-switch; \
 fi

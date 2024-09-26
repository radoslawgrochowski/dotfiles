os := `uname`

_default:
  just --list

update: 
  nix flake update

check: 
  nix flake check --show-trace

darwin-switch: 
  nix run nix-darwin -- switch --flake .#macaron

nixos-switch:
  sudo nixos-rebuild switch --flake .

update-node-packages:
  (cd ./overlays/node-packages/; node2nix -i node-packages.json)

switch:
 @if [ "{{os}}" == "Darwin" ]; then \
   just darwin-switch; \
 else \
   just nixos-switch; \
 fi

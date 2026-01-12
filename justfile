os := `uname`

_default:
  just --list

update: 
  nix flake update

fetchgit *args:
  fd .nix --exec update-nix-fetchgit -v {{args}}

check *args: 
  nix flake check --show-trace {{args}}

update-node-packages:
  (cd ./overlays/node-packages/; node2nix -i node-packages.json)

darwin-switch: 
  sudo darwin-rebuild switch --flake .#macaron

nixos-switch:
  sudo nixos-rebuild switch --flake .

switch:
 @if [ "{{os}}" == "Darwin" ]; then \
   just darwin-switch; \
 else \
   just nixos-switch; \
 fi

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

switch:
 @if [ "{{os}}" == "Darwin" ]; then \
  sudo darwin-rebuild switch --flake .#macaron; \
 else \
  sudo nixos-rebuild switch --flake .; \
 fi

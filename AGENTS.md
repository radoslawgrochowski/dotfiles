# Developer Guide

## Nix fetcher updates

`update-nix-fetchgit` is used to bump `rev`/`sha256` for `fetchFromGitHub` and other fetchers across `.nix` files via `just fetchgit`.

### Pinning a fetcher

To prevent `update-nix-fetchgit` from bumping a fetcher's `rev` or `url`, add a `# pin` comment on the `rev` or `url` attribute line:

```nix
src = pkgs.fetchFromGitHub {
  owner = "expipiplus1";
  repo = "upfind";
  rev = "cb451254f5b112f839aa36e5b6fd83b60cf9b9ae"; # pin
  sha256 = _;
};
```

The hash will still be updated, but the revision stays fixed. Use this for deliberate pins (e.g. a specific nixpkgs commit for a particular package version).

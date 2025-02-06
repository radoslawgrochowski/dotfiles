{ inputs, ... }:
{
  nixpkgsLocalVimPlugins = final: _prev: {
    localVimPlugins = (
      let
        system = final.system;
        pkgs = import inputs.nixpkgs { inherit system; };
      in
      {
        nvim-cmp = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-cmp";
          version = "unstable-2025-01-23";
          src = pkgs.fetchFromGitHub {
            owner = "hrsh7th";
            repo = "nvim-cmp";
            rev = "12509903a5723a876abd65953109f926f4634c30";
            sha256 = "0a592vvfbyv1y1j9bbiq7wxy0vp63bwngjav0qkm0czdf8y4b3kb";
          };
        };
      }
    );
  };
}
        

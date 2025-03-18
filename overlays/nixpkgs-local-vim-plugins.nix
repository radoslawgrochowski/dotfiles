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
        nvim-nio = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-nio";
          version = "unstable-2025-01-20";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-neotest";
            repo = "nvim-nio";
            rev = "21f5324bfac14e22ba26553caf69ec76ae8a7662";
            sha256 = "1bz5msxwk232zkkhfxcmr7a665la8pgkdx70q99ihl4x04jg6dkq";
          };
        };
        neotest = pkgs.vimUtils.buildVimPlugin {
          name = "neotest";
          version = "unstable-2025-01-02";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-neotest";
            repo = "neotest";
            rev = "d66cf4e05a116957f0d3a7755a24291c7d1e1f72";
            sha256 = "09bxarrrfnqvyv22ls6lm0y03ngcp6r372b8hy4rld902psdb11q";
          };
        };
        neotest-jest = pkgs.vimUtils.buildVimPlugin {
          name = "neotest-jest";
          version = "unstable-2024-03-22";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-neotest";
            repo = "neotest-jest";
            rev = "514fd4eae7da15fd409133086bb8e029b65ac43f";
            sha256 = "1lmz248bzdhggvarikhpr5210mbw9fycks93k719d05sb4l6i2dg";
          };
        };
        telescope-oil-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "telescope-oil-nvim";
          version = "unstable-2024-11-30";
          src = pkgs.fetchFromGitHub {
            owner = "albenisolmos";
            repo = "telescope-oil.nvim";
            rev = "1aaeb1a38a515498f1435d3d308049310b9a5f52";
            sha256 = "0k0a2dsix6sjdv3p10vrxf19klkpgbyvlli16x7fskxnsnaav4mx";
          };
        };
      }
    );
  };
}
        

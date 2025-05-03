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
          version = "unstable-2025-03-14";
          src = pkgs.fetchFromGitHub {
            owner = "hrsh7th";
            repo = "nvim-cmp";
            rev = "1e1900b0769324a9675ef85b38f99cca29e203b3";
            sha256 = "1yqg4gnzmlm9h5rcmzv7msjmqna0ffn7gllf5knfkps5ns0ynpyf";
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
          version = "unstable-2025-02-25";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-neotest";
            repo = "neotest";
            rev = "dddbe8fe358b05b2b7e54fe4faab50563171a76d";
            sha256 = "0ji65yyfisr1fpfsx8kflb9fl17dmf168wwvqgvp7z24m9v9b3bb";
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
        parrot-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "parrot-nvim";
          version = "unstable-2025-03-18";
          src = pkgs.fetchFromGitHub {
            owner = "frankroeder";
            repo = "parrot.nvim";
            rev = "3027b481ef58245147408455a13b61608a86885c";
            sha256 = "0ras4vw435pjs5vvy2cfxiga8nlbil88l954ajq85d651wgi9gdj";
          };
        };
        nvim-vtsls = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-vtsls";
          version = "unstable-2024-06-28";
          src = pkgs.fetchFromGitHub {
            owner = "yioneko";
            repo = "nvim-vtsls";
            rev = "45c6dfea9f83a126e9bfc5dd63430562b3f8af16";
            sha256 = "08ms4yg821dk1qvhs7i3qh51hhn43v4p55yi81bbvk6za7n68bgz";
          };
        };
        tsc-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "tsc-nvim";
          version = "unstable-2025-03-12";
          src = pkgs.fetchFromGitHub {
            owner = "dmmulroy";
            repo = "tsc.nvim";
            rev = "5bd25bb5c399b6dc5c00392ade6ac6198534b53a";
            sha256 = "1s47l4m741d7z9diicqn48b5avk1n3sxx64f8xjr6l0rn9518zsz";
          };
        };
        dir-telescope-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "dir-telescope-nvim";
          version = "unstable-2024-08-27";
          src = pkgs.fetchFromGitHub {
            owner = "princejoogie";
            repo = "dir-telescope.nvim";
            rev = "805405b9f98dc3470f8676773dc0e6151a9158ed";
            sha256 = "1aqfvlg3p1kln8par7gaqdzra9lsb29c2hcairv2wmn09191kxq7";
          };
        };
      }
    );
  };
}
        

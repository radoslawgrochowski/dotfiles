{ inputs, ... }:
{
  nixpkgsLocalVimPlugins = final: _prev: {
    localVimPlugins = (
      let
        system = final.stdenv.hostPlatform.system;
        pkgs = import inputs.nixpkgs { localSystem = system; };
      in
      {
        nvim-cmp = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-cmp";
          version = "unstable-2026-07-10";
          src = pkgs.fetchFromGitHub {
            owner = "hrsh7th";
            repo = "nvim-cmp";
            rev = "2ffe79f1f021def8dd1fcd81deb16f1bb0d989f3";
            sha256 = "19z6cgwny9d3i1qzgppc3wxnjjpq4m95k8rnvif03m3gfl0hmpv0";
          };
          doCheck = false;
        };
        telescope-oil-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "telescope-oil-nvim";
          version = "unstable-2026-05-22";
          src = pkgs.fetchFromGitHub {
            owner = "albenisolmos";
            repo = "telescope-oil.nvim";
            rev = "997f0bcc2ec5237b9ad5a1e73d5baf4dfca3a687";
            sha256 = "0zxk1zmr993s0rs942nv8i56np2ng560zifp667z88zlnfpmq5z0";
          };
          doCheck = false;
        };
        tsc-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "tsc-nvim";
          version = "unstable-2026-01-14";
          src = pkgs.fetchFromGitHub {
            owner = "dmmulroy";
            repo = "tsc.nvim";
            rev = "e083bcf1e54bc3af7df92b33235efb334e8c782c";
            sha256 = "0f7as51kc3q3f8x0wv6v6xjdlw35blsnrkhyk2vkblprmryhk3sv";
          };
          doCheck = false;
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
          doCheck = false;
        };
        jiejie-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "jiejie-nvim";
          version = "unstable-2026-07-11";
          src = pkgs.fetchFromGitHub {
            owner = "jceb";
            repo = "jiejie.nvim";
            rev = "29050c87d408e5dff0762eabe86aa8e2b3fff3f9";
            sha256 = "0i9z7kgfhcgsscdj3zcfihbp46v6dnhzjgrpkkqv0bdz7nb28i1x";
          };
          doCheck = false;
        };
        jj-diffconflicts = pkgs.vimUtils.buildVimPlugin {
          name = "jj-diffconflicts";
          version = "unstable-2026-05-19";
          src = pkgs.fetchFromGitHub {
            owner = "rafikdraoui";
            repo = "jj-diffconflicts";
            rev = "a2aa9a247b56d2c1a6f6be81bcf41c5450cc82ff";
            sha256 = "0c2hl1ig27rvl25dwckpjb7j6gqz8cb7hihhnhf00is1d669qdij";
          };
          doCheck = false;
        };
      }
    );
  };
}

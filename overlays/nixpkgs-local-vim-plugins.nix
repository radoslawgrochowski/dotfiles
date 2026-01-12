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
          version = "unstable-2026-01-02";
          src = pkgs.fetchFromGitHub {
            owner = "hrsh7th";
            repo = "nvim-cmp";
            rev = "85bbfad83f804f11688d1ab9486b459e699292d6";
            sha256 = "0j5pasmlan2p1k4c2p5yx30a92jbjqag8fxbd1ll2l7p1i9a42w3";
          };
          doCheck = false;
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
          doCheck = false;
        };
        neotest = pkgs.vimUtils.buildVimPlugin {
          name = "neotest";
          version = "unstable-2025-11-08";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-neotest";
            repo = "neotest";
            rev = "deadfb1af5ce458742671ad3a013acb9a6b41178";
            sha256 = "0qiff2cg7dz96mvfihgb9rgmg0zsjf95nvxnfnzw0pnp65ch4bnh";
          };
          doCheck = false;
        };
        neotest-jest = pkgs.vimUtils.buildVimPlugin {
          name = "neotest-jest";
          version = "unstable-2025-12-27";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-neotest";
            repo = "neotest-jest";
            rev = "3f0cc2cff1ee05394081805c622dc2551b54d8c4";
            sha256 = "0w0jj91gjg2jag5rdlqfwzpb6b00gkrqa2hc040jibw0g0dzvq1c";
          };
          doCheck = false;
        };
        telescope-oil-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "telescope-oil-nvim";
          version = "unstable-2025-04-30";
          src = pkgs.fetchFromGitHub {
            owner = "albenisolmos";
            repo = "telescope-oil.nvim";
            rev = "5a86746e2803f67a98f9801ed4cf9c782d649a93";
            sha256 = "09xw4s724gx6zcjk00af1iyczw35xjgq2w6k2z9fj5farl8wszq8";
          };
          doCheck = false;
        };
        nvim-vtsls = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-vtsls";
          version = "unstable-2025-07-16";
          src = pkgs.fetchFromGitHub {
            owner = "yioneko";
            repo = "nvim-vtsls";
            rev = "0b5f73c9e50ce95842ea07bb3f05c7d66d87d14a";
            sha256 = "0cdc4a1g2gl6m5d0g1kggg2hpr7x078s499y7rwcii8r6yj48cxx";
          };
          doCheck = false;
        };
        tsc-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "tsc-nvim";
          version = "unstable-2026-01-12";
          src = pkgs.fetchFromGitHub {
            owner = "dmmulroy";
            repo = "tsc.nvim";
            rev = "eef9e2a14726c0fd6886acc47cd914c1b3b0f9f0";
            sha256 = "1ha3wppksi0xh9zlc825n8y1z3zfz08pw186krvsj1m0phahbxsc";
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
        opencode-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "opencode-nvim";
          version = "unstable-2026-01-11";
          src = pkgs.fetchFromGitHub {
            owner = "NickvanDyke";
            repo = "opencode.nvim";
            rev = "cb8660e08fb6ecc248f267ff0f45d5be5075c586";
            sha256 = "1wdldzclakhk2k3niwhmd248aah4z74b15ld6psz5mdb1hzd1y3z";
          };
          doCheck = false;
        };
      }
    );
  };
}

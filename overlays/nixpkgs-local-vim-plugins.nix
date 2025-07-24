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
          version = "unstable-2025-04-13";
          src = pkgs.fetchFromGitHub {
            owner = "hrsh7th";
            repo = "nvim-cmp";
            rev = "b5311ab3ed9c846b585c0c15b7559be131ec4be9";
            sha256 = "07674djcyac9wlj08y9p5gsmdpsm8zxjfgk3fwyvvx8j7qyzx74p";
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
          version = "unstable-2025-07-16";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-neotest";
            repo = "neotest";
            rev = "3c81345c28cd639fcc02843ed3653be462f47024";
            sha256 = "1rqfxhy0c721hzz9azp1w403b8bccq6q24miynb42z4hc14qh8nm";
          };
          doCheck = false;
        };
        neotest-jest = pkgs.vimUtils.buildVimPlugin {
          name = "neotest-jest";
          version = "unstable-2025-06-30";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-neotest";
            repo = "neotest-jest";
            rev = "797515e113ac8e19c6855046d7f746d9c0c39c15";
            sha256 = "09xq5dn9rjd37ab8nf85d26qhb0k8np1j17y6nk8pb7dc3l15w4j";
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
        parrot-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "parrot-nvim";
          version = "unstable-2025-07-21";
          src = pkgs.fetchFromGitHub {
            owner = "frankroeder";
            repo = "parrot.nvim";
            rev = "6ad76a1b170b3fa49851504ab17cb39075b93b03";
            sha256 = "1x6knk6n576zyk2927hy2xisp96vmqg5fa1pbq4m0f2vc8g7qiw0";
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
          version = "unstable-2025-05-25";
          src = pkgs.fetchFromGitHub {
            owner = "dmmulroy";
            repo = "tsc.nvim";
            rev = "8c1b4ec6a48d038a79ced8674cb15e7db6dd8ef0";
            sha256 = "00irwjlm3r741i06w6qd6pmgqcs5zh1faz2fnqvlzgm7pyb4qz50";
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
      }
    );
  };
}
        

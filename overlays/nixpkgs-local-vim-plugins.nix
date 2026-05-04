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
          version = "unstable-2026-01-23";
          src = pkgs.fetchFromGitHub {
            owner = "hrsh7th";
            repo = "nvim-cmp";
            rev = "da88697d7f45d16852c6b2769dc52387d1ddc45f";
            sha256 = "056nlgqa62v0nbfazw4r46ccvhclxjcaav5hmyk9x6fmrsj3qfgy";
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
        opencode-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "opencode-nvim";
          version = "unstable-2026-04-02";
          src = pkgs.fetchFromGitHub {
            owner = "NickvanDyke";
            repo = "opencode.nvim";
            rev = "fa0a495fa2c229115404cb3c1970578f9c6d2f76";
            sha256 = "1gwhl6fixg2db8f790lbkx1rkspppypcpldlzlk8a7mvb5j4cn3g";
          };
          doCheck = false;
        };
        jiejie-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "jiejie-nvim";
          version = "unstable-2026-04-17";
          src = pkgs.fetchFromGitHub {
            owner = "jceb";
            repo = "jiejie.nvim";
            rev = "6a3a3598e6e015cfd3f1f447c257314972030e1b";
            sha256 = "0lakfnfjm8a654vqmycprki2p9a6921p9gwlgjx108m52zbrb5my";
          };
          doCheck = false;
        };
      }
    );
  };
}

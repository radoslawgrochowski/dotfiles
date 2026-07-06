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
          version = "unstable-2026-03-25";
          src = pkgs.fetchFromGitHub {
            owner = "hrsh7th";
            repo = "nvim-cmp";
            rev = "a1d504892f2bc56c2e79b65c6faded2fd21f3eca";
            sha256 = "0p2hr29k8cargnzrfnlfs2rnhyvxs83509n6992chani6bqcqdxv";
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
          version = "unstable-2026-05-11";
          src = pkgs.fetchFromGitHub {
            owner = "NickvanDyke";
            repo = "opencode.nvim";
            rev = "a89f9b90e2709f7350743bf2d38e80bc4fd5379d";
            sha256 = "1cgwm1ld1gx5y5lb6x9808zyb84kjsd3yjx336hvh1j8xbr84mbl";
          };
          doCheck = false;
        };
        jiejie-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "jiejie-nvim";
          version = "unstable-2026-06-13";
          src = pkgs.fetchFromGitHub {
            owner = "jceb";
            repo = "jiejie.nvim";
            rev = "e79982899358a15b535dcc901a61b331ebb3e922";
            sha256 = "1fizn2rykf89plxsn7h6gpnf72y04gw0v4p5k893pcwvn05546j9";
          };
          doCheck = false;
        };
        jj-diffconflicts = pkgs.vimUtils.buildVimPlugin {
          name = "jj-diffconflicts";
          version = "unstable-2026-03-22";
          src = pkgs.fetchFromGitHub {
            owner = "rafikdraoui";
            repo = "jj-diffconflicts";
            rev = "58163ae8fe7646179dfd7741206dd9a2b4cdadc0";
            sha256 = "1gbvq4yx82rz3aqldrsnyjmlskznfxbnyc1axlzyh67d9siwwch8";
          };
          doCheck = false;
        };
      }
    );
  };
}

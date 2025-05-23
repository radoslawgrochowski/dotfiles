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
          version = "unstable-2025-05-12";
          src = pkgs.fetchFromGitHub {
            owner = "nvim-neotest";
            repo = "neotest";
            rev = "862afb2a2219d9ca565f67416fb7003cc0f22c4f";
            sha256 = "1mpfqpkb15ynq10zplia8c4zz49wi301ix70b5q7z02af9jc9p17";
          };
        };
        # neotest-jest = pkgs.vimUtils.buildVimPlugin {
        #   name = "neotest-jest";
        #   version = "unstable-2024-03-22";
        #   src = pkgs.fetchFromGitHub {
        #     owner = "nvim-neotest";
        #     repo = "neotest-jest";
        #     rev = "514fd4eae7da15fd409133086bb8e029b65ac43f";
        #     sha256 = "1lmz248bzdhggvarikhpr5210mbw9fycks93k719d05sb4l6i2dg";
        #   };
        # };
        telescope-oil-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "telescope-oil-nvim";
          version = "unstable-2025-04-30";
          src = pkgs.fetchFromGitHub {
            owner = "albenisolmos";
            repo = "telescope-oil.nvim";
            rev = "5a86746e2803f67a98f9801ed4cf9c782d649a93";
            sha256 = "09xw4s724gx6zcjk00af1iyczw35xjgq2w6k2z9fj5farl8wszq8";
          };
        };
        parrot-nvim = pkgs.vimUtils.buildVimPlugin {
          name = "parrot-nvim";
          version = "unstable-2025-05-19";
          src = pkgs.fetchFromGitHub {
            owner = "frankroeder";
            repo = "parrot.nvim";
            rev = "758c3acad75469434700b28ee756d6515fdf7c1a";
            sha256 = "1kqcm4ghi8fhvpnv972a796pc4r5nswdvl4vazw0v0y5a0cd9wvz";
          };
        };
        nvim-vtsls = pkgs.vimUtils.buildVimPlugin {
          name = "nvim-vtsls";
          version = "unstable-2025-04-27";
          src = pkgs.fetchFromGitHub {
            owner = "yioneko";
            repo = "nvim-vtsls";
            rev = "60b493e641d3674c030c660cabe7a2a3f7a914be";
            sha256 = "00qj7b70afpgxmb6ml4knjwdwcn29yk8mvsb575b6ww9zsxh34il";
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
        

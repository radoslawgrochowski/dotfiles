{ inputs, ... }:
{
  nixpkgsLocalVimPlugins = final: _prev: {
    localVimPlugins = (
      let
        system = final.system;
        pkgs = import inputs.nixpkgs { inherit system; };
      in
      {
        markdown-nvim = pkgs.vimUtils.buildVimPlugin
          {
            name = "markdown-nvim";
            src = pkgs.fetchFromGitHub {
              owner = "MeanderingProgrammer";
              repo = "render-markdown.nvim";
              rev = "25bfaf06d41c2afee3614b8428344857b6cf2e44";
              hash = "sha256-++5E0R6zTLIMXMFZbEqwB3DMEwbLifjQFWWfTVWwWCo=";
            };
          };
        nvim-cmp = pkgs.vimUtils.buildVimPlugin
          {
            name = "nvim-cmp";
            src = pkgs.fetchFromGitHub {
              owner = "hrsh7th";
              repo = "nvim-cmp";
              rev = "f17d9b4394027ff4442b298398dfcaab97e40c4f";
              hash = "sha256-iNEoMl/X0nh2sAio1h+dkuobeOXRBXKFJCcElUyyW54=";
            };
          };
        neotest = pkgs.vimUtils.buildVimPlugin
          {
            name = "neotest";
            src = pkgs.fetchFromGitHub {
              owner = "nvim-neotest";
              repo = "neotest";
              rev = "d66cf4e05a116957f0d3a7755a24291c7d1e1f72";
              hash = "sha256-OITV9BUgNZqJh2iJM7K57NkBPKjUaCrE9htbl3NWfSU=";
            };
          };
        neotest-jest = pkgs.vimUtils.buildVimPlugin
          {
            name = "neotest-jest";
            src = pkgs.fetchFromGitHub {
              owner = "nvim-neotest";
              repo = "neotest-jest";
              rev = "514fd4eae7da15fd409133086bb8e029b65ac43f";
              hash = "sha256-r4loKFm6gJbCmSPpybxLfFUQRMkXzpjVfg+2vxARv9I=";
            };
          };
      }
    );
  };
}
        

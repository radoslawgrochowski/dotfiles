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
        parrot-nvim = pkgs.vimUtils.buildVimPlugin
          {
            name = "parrot-nvim";
            src = pkgs.fetchFromGitHub {
              owner = "frankroeder";
              repo = "parrot.nvim";
              rev = "c5294031a41fea6e32b107d4140bcfb3ce574b4b";
              hash = "sha256-/PKJRU712bln7OFkwN5GC5TURQ2kjbwqaO4L95QPe4I=";
            };
          };
      }
    );
  };
}
        

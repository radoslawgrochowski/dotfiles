{ inputs, ... }:
{
  nixpkgsLocalVimPlugins = final: _prev: {
    localVimPlugins = (
      let
        system = final.system;
        pkgs = import inputs.nixpkgs { inherit system; };
      in
      {
        vtsls-nvim = pkgs.vimUtils.buildVimPlugin
          {
            name = "vtsls-nvim";
            src = pkgs.fetchFromGitHub {
              owner = "yioneko";
              repo = "nvim-vtsls";
              rev = "45c6dfea9f83a126e9bfc5dd63430562b3f8af16";
              hash = "sha256-/y1k7FHfzL1WQNGXcskexEIYCsQjHg03DrMFgZ4nuiI=";
            };
          };
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
      }
    );
  };
}
        

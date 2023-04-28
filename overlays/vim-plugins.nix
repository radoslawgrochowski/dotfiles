(self: super:
  let
    other-nvim = super.vimUtils.buildVimPlugin {
      name = "other-nvim";
      src = inputs.other-nvim;
    };
  in
  {
    vimPlugins =
      super.vimPlugins // {
        inherit other-nvim;
      };
  }
)

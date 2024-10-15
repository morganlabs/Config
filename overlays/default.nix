{ inputs }:
[
  inputs.nur.overlay

  (final: prev: {
    vimPlugins = prev.vimPlugins // {
      scroll-eof-nvim = prev.vimUtils.buildVimPlugin {
        name = "scroll-eof-nvim";
        src = inputs.nvim-plugin-scroll-eof;
      };
    };
  })
]

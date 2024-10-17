{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.basic.default.fonts;
in
with lib;
{
  options.nixosModules.basic.default.fonts = {
    enable = mkEnableOption "Enable basic.default.fonts";
  };

  config = mkIf cfg.enable {
    fonts = {
      packages = with pkgs; [
        freefont_ttf
        noto-fonts-cjk-sans
        emojione
        (nerdfonts.override { fonts = [ "IBMPlexMono" ]; })
      ];

      fontconfig = {
        defaultFonts = {
          monospace = [ "BlexMono Nerd Font" ];
          emoji = [ "OpenMoji Color" ];
        };
      };
    };
  };
}

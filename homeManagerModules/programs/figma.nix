{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.figma;
in
with lib;
{
  options.homeManagerModules.programs.figma = {
    enable = mkEnableOption "Enable programs.figma";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      figma-linux
      figma-agent
    ];
  };
}

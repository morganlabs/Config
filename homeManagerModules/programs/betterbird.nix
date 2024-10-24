{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.betterbird;
in
with lib;
{
  options.homeManagerModules.programs.betterbird = {
    enable = mkEnableOption "Enable programs.betterbird";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ betterbird ];
  };
}

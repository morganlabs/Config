{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.kid3;
in
with lib;
{
  options.homeManagerModules.programs.kid3 = {
    enable = mkEnableOption "Enable programs.kid3";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ kid3 ];
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.slack;
in
with lib;
{
  options.homeManagerModules.programs.slack = {
    enable = mkEnableOption "Enable programs.slack";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ slack ];
  };
}

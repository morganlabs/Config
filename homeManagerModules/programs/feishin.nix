{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.feishin;
in
with lib;
{
  options.homeManagerModules.programs.feishin = {
    enable = mkEnableOption "Enable programs.feishin";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ feishin ];
  };
}

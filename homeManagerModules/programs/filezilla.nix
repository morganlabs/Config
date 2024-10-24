{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.filezilla;
in
with lib;
{
  options.homeManagerModules.programs.filezilla = {
    enable = mkEnableOption "Enable programs.filezilla";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ filezilla ];
  };
}

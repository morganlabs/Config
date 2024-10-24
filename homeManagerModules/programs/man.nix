{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.man;
in
with lib;
{
  options.homeManagerModules.programs.man = {
    enable = mkEnableOption "Enable programs.man";
  };

  config = mkIf cfg.enable {
    programs.man = {
      enable = true;
      generateCaches = true;
    };
  };
}

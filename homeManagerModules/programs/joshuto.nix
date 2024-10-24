{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.joshuto;
in
with lib;
{
  options.homeManagerModules.programs.joshuto = {
    enable = mkEnableOption "Enable programs.joshuto";
  };

  config = mkIf cfg.enable {
    programs.joshuto = {
      enable = true;
    };
  };
}

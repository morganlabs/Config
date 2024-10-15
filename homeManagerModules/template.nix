{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.SCOPE.NAME;
in
with lib;
{
  options.homeManagerModules.SCOPE.NAME = {
    enable = mkEnableOption "Enable SCOPE.NAME";
  };

  config = mkIf cfg.enable { };
}

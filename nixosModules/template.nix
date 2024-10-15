{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.SCOPE.NAME;
in
with lib;
{
  options.nixosModules.SCOPE.NAME = {
    enable = mkEnableOption "Enable SCOPE.NAME";
  };

  config = mkIf cfg.enable { };
}

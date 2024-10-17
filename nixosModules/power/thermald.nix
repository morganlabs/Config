{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.power.thermald;
in
with lib;
{
  options.nixosModules.power.thermald = {
    enable = mkEnableOption "Enable power.thermald";
  };

  config = mkIf cfg.enable {
    services.thermald.enable = true;
  };
}

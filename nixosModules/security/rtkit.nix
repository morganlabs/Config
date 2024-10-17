{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.security.rtkit;
in
with lib;
{
  options.nixosModules.security.rtkit = {
    enable = mkEnableOption "Enable security.rtkit";
  };

  config = mkIf cfg.enable {
    security.rtkit.enable = true;
  };
}

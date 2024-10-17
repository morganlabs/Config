{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.security.polkit;
in
with lib;
{
  options.nixosModules.security.polkit = {
    enable = mkEnableOption "Enable security.polkit";
  };

  config = mkIf cfg.enable {
    security.polkit.enable = true;
  };
}

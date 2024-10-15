{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.connectivity.bluetooth;
in
with lib;
{
  options.nixosModules.connectivity.bluetooth = {
    enable = mkEnableOption "Enable connectivity.bluetooth";

    features = {
      blueman.enable = mkBoolOption "Enable Blueman" false;
      autostart.enable = mkBoolOption "Autostart Bluetooth" false;
    };
  };

  config = mkIf cfg.enable {
    hardware.bluetooth = {
      enable = true;
      powerOnBoot = cfg.features.autostart.enable;
    };
  };
}

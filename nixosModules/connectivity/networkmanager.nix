{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.connectivity.networkmanager;
in
with lib;
{
  options.nixosModules.connectivity.networkmanager = {
    enable = mkEnableOption "Enable connectivity.networkmanager";

    wifi = {
      enable = mkBoolOption "Enable WiFi support" false;
      useIwd = mkBoolOption "Use IWD over wpa_supplicant for WiFi" true;
    };
  };

  config = mkIf cfg.enable {
    networking = {
      networkmanager = {
        enable = true;
        wifi.backend = mkIfElse cfg.wifi.useIwd "iwd" "wpa_supplicant";
      };
    };
  };
}

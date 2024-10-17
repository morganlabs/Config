{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.power.tlp;
in
with lib;
{
  options.nixosModules.power.tlp = {
    enable = mkEnableOption "Enable power.tlp";

    energy.cpu.policy = {
      onBattery = mkStrOption "Set CPU energy preference on battery" "power";
      onCharger = mkStrOption "Set CPU energy preference while charging" "performance";
    };
    powersave = {
      audio = {
        onBattery = mkBoolOption "Power save audio on battery" false;
        onCharger = mkBoolOption "Power save audio while charging" false;
      };
      wifi = {
        onBattery = mkBoolOption "Power save wifi on battery" false;
        onCharger = mkBoolOption "Power save wifi while charging" false;
      };
      disableRadios = {
        onStartup = mkStrOption "Disable these radios on startup" "wwan";
        onShutdown = mkStrOption "Disable these radios on startup" "bluetooth wifi wwan";
        onChargerUnplug = mkStrOption "Disable these radios when unplugged from battery **and** the radio is not being used" "bluetooth";
        onEthernetConnect = mkStrOption "Disable these radios when connected to ethernet" "wifi";
      };
      enableRadios.onEthernetDisconnect = mkStrOption "Enable these radios when ethernet is disconnected" "wifi";
    };
  };

  config = mkIf cfg.enable {
    services.tlp = {
      enable = true;
      settings = {
        SOUND_POWER_SAVE_ON_BAT = cfg.powersave.audio.onBattery;
        SOUND_POWER_SAVE_ON_AC = cfg.powersave.audio.onCharger;

        WIFI_PWR_ON_BAT = mkIfElse cfg.powersave.wifi.onBattery "on" "off";
        WIFI_PWR_ON_AC = mkIfElse cfg.powersave.wifi.onCharger "on" "off";

        CPU_ENERGY_PERF_POLICY_ON_AC = cfg.energy.cpu.policy.onCharger;
        CPU_ENERGY_PERF_POLICY_ON_BAT = cfg.energy.cpu.policy.onBattery;

        # Enable/Disable radios on certain events
        DEVICES_TO_DISABLE_ON_STARTUP = cfg.powersave.disableRadios.onStartup;
        DEVICES_TO_DISABLE_ON_SHUTDOWN = cfg.powersave.disableRadios.onShutdown;
        DEVICES_TO_DISABLE_ON_BAT_NOT_IN_USE = cfg.powersave.disableRadios.onChargerUnplug;
        DEVICES_TO_DISABLE_ON_LAN_CONNECT = cfg.powersave.disableRadios.onEthernetConnect;
        DEVICES_TO_ENABLE_ON_LAN_DISCONNECT = cfg.powersave.enableRadios.onEthernetDisconnect;

        USB_EXCLUDE_WWAN = 1;
      };
    };
  };
}

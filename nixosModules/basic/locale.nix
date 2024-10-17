{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.basic.locale;
in
with lib;
{
  options.nixosModules.basic.locale = {
    enable = mkEnableOption "Enable basic.locale";
  };

  config = mkIf cfg.enable {
    time.timeZone = "Europe/London";
    console.keyMap = "uk";
    i18n = {
      defaultLocale = "en_GB.UTF-8";
      extraLocaleSettings = {
        LC_ADDRESS = "en_GB.UTF-8";
        LC_IDENTIFICATION = "en_GB.UTF-8";
        LC_MEASUREMENT = "en_GB.UTF-8";
        LC_MONETARY = "en_GB.UTF-8";
        LC_NAME = "en_GB.UTF-8";
        LC_NUMERIC = "en_GB.UTF-8";
        LC_PAPER = "en_GB.UTF-8";
        LC_TELEPHONE = "en_GB.UTF-8";
        LC_TIME = "en_GB.UTF-8";
      };
    };

    services.xserver.xkb = {
      layout = "gb";
      variant = "";
    };
  };
}

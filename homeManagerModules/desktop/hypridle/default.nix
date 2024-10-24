{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.desktop.hypridle;
in
with lib;
{
  options.homeManagerModules.desktop.hypridle = {
    enable = mkEnableOption "Enable desktop.hypridle";

    timeout = {
      lock = mkOptionInt "How many minutes until the device auto-locks" 5;
      sleep = mkOptionInt "How many minutes until the device auto-sleeps" 10;
    };
  };

  config =
    let
      timeoutUntil = {
        lock = cfg.timeout.lock * 60;
        sleep = cfg.timeout.sleep * 60;
      };
    in
    mkIf cfg.enable {
      services.hypridle = {
        enable = true;
        settings = import ./settings.nix { inherit timeoutUntil; };
      };
    };
}

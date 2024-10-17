{ cfg, lib, ... }:
with lib;
{
  layer = "top";
  position = "top";
  height = 32;

  modules-left = [
    "hyprland/workspaces"
    "hyprland/window"
  ];
  modules-center = [ "clock" ];
  modules-right =
    with cfg.modules;
    builtins.concatLists [
      (mkIfList brightness.enable [ "backlight" ])
      (mkIfList volume.enable [ "pulseaudio" ])
      (mkIfList battery.enable [ "battery" ])
      (mkIfList bluetooth.enable [ "battery" ])
      (mkIfList network.enable [ "network" ])
      "tray"
    ];
}

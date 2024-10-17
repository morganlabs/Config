{ pkgs, ... }:
{
  imports = [ ../../waybar ];

  homeManagerModules = {
    waybar.enable = true;
  };

  wayland.windowManager.hyprland.settings.exec-once = [
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "${pkgs.waybar}/bin/waybar"
  ];
}

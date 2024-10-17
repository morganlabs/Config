{ pkgs, ... }:
{
  exec-once = [
    "dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
    "${pkgs.waybar}/bin/waybar"
  ];
}

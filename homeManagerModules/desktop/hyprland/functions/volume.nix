{ pkgs }:
{
  home.packages = with pkgs; [ pamixer ];
  wayland.windowManager.hyprland.settings.bind = [
    ", XF86AudioRaiseVolume, exec, pamixer -i 5"
    ", XF86AudioLowerVolume, exec, pamixer -d 5"
    ", XF86AudioMute, exec, pamixer --toggle-mute"
  ];
}

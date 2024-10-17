{ pkgs }:
{
  home.packages = with pkgs; [ playerctl ];
  wayland.windowManager.hyprland.settings.bind = [
    ", XF86AudioPlay, exec, playerctl, play-pause"
    ", XF86AudioPause, exec, playerctl, play-pause"
    ", XF86AudioNext, exec, playerctl, next"
    ", XF86AudioPrev, exec, playerctl, previous"
    ", XF86AudioStop, exec, playerctl, stop"
  ];
}

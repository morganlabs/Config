{ pkgs }:
{
  home.packages = with pkgs; [ brightnessctl ];
  wayland.windowManager.hyprland.settings.bind = [
    ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
    ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
  ];
}

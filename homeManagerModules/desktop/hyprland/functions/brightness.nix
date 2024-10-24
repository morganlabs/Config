{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
mkIf config.homeManagerModules.desktop.hyprland.functions.brightness.enable {
  home.packages = with pkgs; [ brightnessctl ];
  wayland.windowManager.hyprland.extraConfig =
    with pkgs;
    concatStringsSep "\n" [
      "bind = , XF86MonBrightnessUp, exec, ${brightnessctl}/bin/brightnessctl set +5%"
      "bind = , XF86MonBrightnessDown, exec, ${brightnessctl}/bin/brightnessctl set 5%-"
    ];
}

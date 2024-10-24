{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
mkIf config.homeManagerModules.desktop.hyprland.functions.volume.enable {
  home.packages = with pkgs; [ pamixer ];
  wayland.windowManager.hyprland.extraConfig =
    with pkgs;
    concatStringsSep "\n" [
      "bind = , XF86AudioRaiseVolume, exec, ${pamixer}/bin/pamixer -i 5"
      "bind = , XF86AudioLowerVolume, exec, ${pamixer}/bin/pamixer -d 5"
      "bind = , XF86AudioMute, exec, ${pamixer}/bin/pamixer --toggle-mute"
    ];
}

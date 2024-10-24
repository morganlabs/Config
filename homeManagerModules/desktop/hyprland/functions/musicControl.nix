{
  pkgs,
  lib,
  config,
  ...
}:
with lib;
mkIf config.homeManagerModules.desktop.hyprland.functions.musicControl.enable {
  home.packages = with pkgs; [ playerctl ];
  wayland.windowManager.hyprland.extraConfig =
    with pkgs;
    concatStringsSep "\n" [
      "bind = , XF86AudioPlay, exec, ${playerctl}/bin/playerctl play-pause"
      "bind = , XF86AudioPause, exec, ${playerctl}/bin/playerctl play-pause"
      "bind = , XF86AudioNext, exec, ${playerctl}/bin/playerctl next"
      "bind = , XF86AudioPrev, exec, ${playerctl}/bin/playerctl previous"
      "bind = , XF86AudioStop, exec, ${playerctl}/bin/playerctl stop"
    ];
}

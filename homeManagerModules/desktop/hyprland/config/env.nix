{ lib, config, ... }:
with lib;
mkIf config.homeManagerModules.desktop.hyprland.config.includeDefault.env {
  wayland.windowManager.hyprland.extraConfig = concatStringsSep "\n" [
    "env = XDG_CURRENT_DESKTOP,Hyprland"
    "env = XDG_SESSION_TYPE,wayland"
    "env = XDG_SESSION_DESKTOP,Hyprland"
  ];
}

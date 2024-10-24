{ lib, config, ... }:
with lib;
mkIf config.homeManagerModules.desktop.hyprland.config.includeDefault.inputs {
  wayland.windowManager.hyprland.extraConfig = ''
    input {
      kb_layout = gb
      kb_options = caps:escape

      follow_mouse = true
      sensitivity = 0

      touchpad:natural_scroll = true
    }
  '';
}

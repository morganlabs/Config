{ lib, config, ... }:
with lib;
mkIf config.homeManagerModules.desktop.hyprland.config.includeDefault.windowRules {
  wayland.windowManager.hyprland.extraConfig = concatStringsSep "\n" [
    "windowrulev2 = suppressevent maximize, class:.*"

    # General floating windows
    "windowrulev2 = center, floating:1"

    # File Chooser - Floating, centred
    "windowrulev2 = float, initialTitle:(Open Files)"
    "windowrulev2 = center, initialTitle:(Open Files)"

    # Steam Settings - Floating, centred
    "windowrulev2 = float, initialTitle:(Steam Settings)"
    "windowrulev2 = center, initialTitle:(Steam Settings)"

    # Vesktop - Special workspace, floating
    "windowrulev2 = workspace special:vesktop, class:(vesktop)"
    "windowrulev2 = float, class:(vesktop)"
    "windowrulev2 = size 75% 75%, class:(vesktop)"
    "windowrulev2 = center, class:(vesktop)"

    # Slack - Special workspace, floating
    "windowrulev2 = workspace special:slack, class:(Slack)"
    "windowrulev2 = float, class:(Slack)"
    "windowrulev2 = size 75% 75%, class:(Slack)"
    "windowrulev2 = center, class:(Slack)"

    # Betterbird - Special workspace, maximised
    "windowrulev2 = workspace special:mail, class:(betterbird)"
    "windowrulev2 = fullscreen, class:(betterbird)"
    "windowrulev2 = fullscreenstate:1, class:(betterbird)"

    # Pavucontrol - Floating
    "windowrulev2 = float, class:(org.pulseaudio.pavucontrol)"
    "windowrulev2 = size 75% 75%, class:(org.pulseaudio.pavucontrol)"
    "windowrulev2 = center, class:(org.pulseaudio.pavucontrol)"

    # Blueman Manager - Floating
    "windowrulev2 = float, class:(blueman-manager-wrapped)"
    "windowrulev2 = size 75% 75%, class:(blueman-manager-wrapped)"
    "windowrulev2 = center, class:(blueman-manager-wrapped)"
  ];
}

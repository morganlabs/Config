{ ... }:
{
  windowrulev2 = [
    "suppressevent maximize, class:.*"

    "size 75% 75%, floating:1"
    "center, floating:1"

    # File Chooser - Floating
    "float, initialTitle:(Open Files)"
    "size 65% 65%, initialTitle:(Open Files)"
    "center, initialTitle:(Open Files)"

    # Discord - Special workspace, floating
    "workspace special:discord, class:(discord)"
    "float, class:(discord)"
    "size 75% 75%, class:(discord)"
    "center, class:(discord)"

    # Slack - Special workspace, floating
    "workspace special:slack, class:(Slack)"
    "float, class:(Slack)"
    "size 75% 75%, class:(Slack)"
    "center, class:(Slack)"

    # Betterbird - Special workspace, maximised
    "workspace special:mail, class:(betterbird)"
    "fullscreen, class:(betterbird)"
    "fullscreenstate:1, class:(betterbird)"

    # Pavucontrol - Floating
    "float, class:(org.pulseaudio.pavucontrol)"
    "size 75% 75%, class:(org.pulseaudio.pavucontrol)"
    "center, class:(org.pulseaudio.pavucontrol)"

    # Blueman Manager - Floating
    "float, class:(blueman-manager-wrapped)"
    "size 75% 75%, class:(blueman-manager-wrapped)"
    "center, class:(blueman-manager-wrapped)"
  ];
}

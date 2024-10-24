{
  pkgs,
  lib,
  config,
  ...
}:
let
  hmModules = config.homeManagerModules;
in
with lib;
mkIf config.homeManagerModules.desktop.hyprland.config.includeDefault.binds {
  wayland.windowManager.hyprland.extraConfig =
    with pkgs;
    concatStringsSep "\n" [
      # Run programs
      (mkIfStr hmModules.programs.kitty.enable "bind = $mod, Return, exec, ${pkgs.kitty}/bin/kitty")
      (mkIfStr hmModules.desktop.hyprlock.enable "bind = $alt SHIFT, Q, exec, ${pkgs.hyprlock}/bin/hyprlock --immediate")
      (mkIfStr hmModules.desktop.rofi.enable "bind = $mod, D, exec, ${pkgs.rofi-wayland}/bin/rofi -show drun")

      # Special Workspaces
      (mkIfStr hmModules.programs.vesktop.enable "bind = $mod, grave, togglespecialworkspace, vesktop")
      (mkIfStr hmModules.programs.slack.enable "bind = $mod SHIFT, grave, togglespecialworkspace, slack")
      (mkIfStr hmModules.programs.betterbird.enable "bind = $alt, grave, togglespecialworkspace, mail")

      # Window Actions 
      "bind = $mod Shift, Q, killactive,"
      "bind = $mod Shift, Space, togglefloating,"
      "bind = $mod, F, fullscreen, 1" # Maximize
      "bind = $mod Shift, F, fullscreen, 0" # Fullscreen

      ## Move Focus
      ### Mod+{LRUD}
      "bind = $mod, left, movefocus, l"
      "bind = $mod, right, movefocus, r"
      "bind = $mod, up, movefocus, u"
      "bind = $mod, down, movefocus, d"

      ### Mod+{HJKL}
      "bind = $mod, h, movefocus, l"
      "bind = $mod, j, movefocus, r"
      "bind = $mod, k, movefocus, u"
      "bind = $mod, l, movefocus, d"

      ## Move Window
      ### Mod+{LRUD}
      "bind = $mod Shift, left, movewindow, l"
      "bind = $mod Shift, right, movewindow, r"
      "bind = $mod Shift, up, movewindow, u"
      "bind = $mod Shift, down, movewindow, d"

      ### Mod+{HJKL}
      "bind = $mod Shift, h, movewindow, l"
      "bind = $mod Shift, j, movewindow, r"
      "bind = $mod Shift, k, movewindow, u"
      "bind = $mod Shift, l, movewindow, d"

      ## Switch workspaces
      "bind = $mod, 1, workspace, 1"
      "bind = $mod, 2, workspace, 2"
      "bind = $mod, 3, workspace, 3"
      "bind = $mod, 4, workspace, 4"
      "bind = $mod, 5, workspace, 5"
      "bind = $mod, 6, workspace, 6"
      "bind = $mod, 7, workspace, 7"
      "bind = $mod, 8, workspace, 8"
      "bind = $mod, 9, workspace, 9"
      "bind = $mod, 0, workspace, 10"

      ## Move window to workspace
      "bind = $mod Shift, 1, movetoworkspace, 1"
      "bind = $mod Shift, 2, movetoworkspace, 2"
      "bind = $mod Shift, 3, movetoworkspace, 3"
      "bind = $mod Shift, 4, movetoworkspace, 4"
      "bind = $mod Shift, 5, movetoworkspace, 5"
      "bind = $mod Shift, 6, movetoworkspace, 6"
      "bind = $mod Shift, 7, movetoworkspace, 7"
      "bind = $mod Shift, 8, movetoworkspace, 8"
      "bind = $mod Shift, 9, movetoworkspace, 9"
      "bind = $mod Shift, 0, movetoworkspace, 10"

      "bindm = $mod, mouse:272, movewindow"
      "bindm = $mod, mouse:273, resizewindow"
    ];
}

{
  pkgs,
  lib,
  osConfig,
  config,
  ...
}:
let
  hmModules = config.homeManagerModules;
  osPrograms = osConfig.programs;
in
with lib;
mkIf config.homeManagerModules.desktop.hyprland.config.includeDefault.autostart {
  wayland.windowManager.hyprland.extraConfig =
    with pkgs;
    concatStringsSep "\n" [
      "exec-once = dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP"
      (mkIfStr hmModules.desktop.waybar.enable "exec-once = ${waybar}/bin/waybar")
      (mkIfStr osPrograms._1password-gui.enable "exec-once = ${_1password-gui}/bin/1password --silent")
      (mkIfStr osPrograms.noisetorch.enable "exec-once = noisetorch -i")

      (mkIfStr hmModules.programs.kitty.enable "exec-once = [workspace 1 silent] ${kitty}/bin/kitty")
      (mkIfStr hmModules.programs.firefox.enable "exec-once = [workspace 2 silent] ${firefox}/bin/firefox")
      (mkIfStr hmModules.programs.obsidian.enable "exec-once = [workspace 3 silent] ${obsidian}/bin/obsidian")
      (mkIfStr hmModules.programs.vesktop.enable "exec-once = [workspace special:vesktop silent] ${vesktop}/bin/vesktop")
      (mkIfStr hmModules.programs.slack.enable "exec-once = [workspace special:slack silent] ${slack}/bin/slack")
      (mkIfStr hmModules.programs.betterbird.enable "exec-once = [workspace special:mail silent] ${betterbird}/bin/betterbird")
      (mkIfStr hmModules.programs.vesktop.features.discover.enable "exec-once = ${discover-overlay}/bin/discover-overlay")
    ];
}

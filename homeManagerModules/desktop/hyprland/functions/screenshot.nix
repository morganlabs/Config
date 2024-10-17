{ pkgs }:
{
  home.packages = with pkgs; [
    (writeShellScriptBin "screenshot" (builtins.readFile ../scripts/screenshot.sh))
    slurp
    grim
    jq
  ];

  wayland.windowManager.hyprland.settings.bind = [
    "ALT SHIFT, 1, exec, screenshot selection"
    "ALT SHIFT, 2, exec, screenshot window"
    "ALT SHIFT, 3, exec, screenshot all"
  ];
}

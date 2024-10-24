{
  pkgs,
  lib,
  config,
  ...
}:
let
  screenshotBin = pkgs.writeShellScriptBin "screenshot" (builtins.readFile ../scripts/screenshot.sh);
in
with lib;
mkIf config.homeManagerModules.desktop.hyprland.functions.screenshot.enable {
  home.packages = with pkgs; [
    screenshotBin
    slurp
    grim
    jq
  ];

  wayland.windowManager.hyprland.extraConfig = concatStringsSep "\n" [
    "bind = $alt SHIFT, 1, exec, ${screenshotBin}/bin/screenshot selection"
    "bind = $alt SHIFT, 2, exec, ${screenshotBin}/bin/screenshot window"
    "bind = $alt SHIFT, 3, exec, ${screenshotBin}/bin/screenshot all"
  ];
}

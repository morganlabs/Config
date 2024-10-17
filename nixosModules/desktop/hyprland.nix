{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cfg = config.nixosModules.desktop.hyprland;
in
with lib;
{
  options.nixosModules.desktop.hyprland = {
    enable = mkEnableOption "Enable desktop.hyprland";
  };

  config = mkIf cfg.enable {
    programs.hyprland = with inputs; {
      enable = true;
      package = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
      portalPackage = hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
    };
  };
}

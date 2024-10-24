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

    nix.settings = {
      substituters = [ "https://hyprland.cachix.org" ];
      trusted-public-keys = [ "hyprland.cachix.org-1:a7pgxzMz7+chwVL3/pzj6jIBMioiJM7ypFP8PwtkuGc=" ];
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.desktop.waybar;
in
with lib;
{
  options.homeManagerModules.desktop.waybar = {
    enable = mkEnableOption "Enable desktop.waybar";

    bars.hyprland.enable = mkOptionBool "Enable the Hyprland waybar";
  };

  config = mkIf cfg.enable {
    imports = [ ./modules ];

    programs.waybar = {
      enable = true;

      style = import ./style.nix { inherit config; };

      settings = mkMerge [
        (mkIf cfg.bars.hyprland.enable import ./bars/hyprland.nix { inherit cfg lib; })
      ];
    };
  };
}

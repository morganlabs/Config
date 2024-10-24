{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.desktop.hyprlock;
in
with lib;
{
  options.homeManagerModules.desktop.hyprlock = {
    enable = mkEnableOption "Enable desktop.hyprlock";
  };

  config = mkIf cfg.enable {
    programs.hyprlock = {
      settings = import ./settings.nix { inherit config; };
    };
  };
}

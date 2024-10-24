{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.obsidian;
in
with lib;
{
  options.homeManagerModules.programs.obsidian = {
    enable = mkEnableOption "Enable programs.obsidian";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ obsidian ];
  };
}

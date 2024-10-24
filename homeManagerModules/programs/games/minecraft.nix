{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.games.minecraft;
in
with lib;
{
  options.homeManagerModules.programs.games.minecraft = {
    enable = mkEnableOption "Enable programs.games.minecraft";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (pkgs.prismlauncher.override {
        jdks = with pkgs; [
          temurin-bin-21
          temurin-bin-8
          temurin-bin-17
        ];
      })
    ];
  };
}

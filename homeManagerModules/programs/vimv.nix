{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.vimv;
in
with lib;
{
  options.homeManagerModules.programs.vimv = {
    enable = mkEnableOption "Enable programs.vimv";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ vimv ];
  };
}

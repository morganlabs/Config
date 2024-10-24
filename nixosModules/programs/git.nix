{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.programs.git;
in
with lib;
{
  options.nixosModules.programs.git = {
    enable = mkEnableOption "Enable programs.git";
  };

  config = mkIf cfg.enable {
    programs.git.enable = true;
  };
}

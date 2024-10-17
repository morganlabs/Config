{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.sound.noisetorch;
in
with lib;
{
  options.nixosModules.sound.noisetorch = {
    enable = mkEnableOption "Enable sound.noisetorch";
  };

  config = mkIf cfg.enable {
    programs.noisetorch.enable = true;
  };
}

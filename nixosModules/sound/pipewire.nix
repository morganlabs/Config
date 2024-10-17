{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.sound.pipewire;
in
with lib;
{
  options.nixosModules.sound.pipewire = {
    enable = mkEnableOption "Enable sound.pipewire";
  };

  config = mkIf cfg.enable {
    services.pipewire = {
      enable = true;
      pulse.enable = true;
      jack.enable = true;
      alsa = {
        enable = true;
        support32Bit = true;
      };
    };
  };
}

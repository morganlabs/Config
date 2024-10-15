{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.boot.grub;
in
with lib;
{
  options.nixosModules.boot.grub = {
    enable = mkEnableOption "Enable boot.grub";
  };

  config = mkIf cfg.enable {
    boot.loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };

      efi = {
        canTouchEfiVariables = true;
        efiSysMountPoint = "/boot";
      };
    };
  };
}

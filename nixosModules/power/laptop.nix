{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.power.laptop;
in
with lib;
{
  options.nixosModules.power.laptop = {
    enable = mkEnableOption "Enable power.laptop";
  };

  config = mkIf cfg.enable {
    imports = [
      ./tlp.nix
      ./thermald.nix
    ];

    roles = {
      tlp.enable = true;
      thermald.enable = true;
    };
  };
}

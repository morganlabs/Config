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
  imports = [
    ./tlp.nix
    ./thermald.nix
  ];

  options.nixosModules.power.laptop = {
    enable = mkEnableOption "Enable power.laptop";
  };

  config = mkIf cfg.enable {
    nixosModules.power = {
      tlp.enable = true;
      thermald.enable = true;
    };
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.basic.default.nix;
in
with lib;
{
  options.nixosModules.basic.default.nix = {
    enable = mkEnableOption "Enable basic.default.nix";
  };

  config = mkIf cfg.enable {
    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.connectivity.controldDns;
in
with lib;
{
  options.nixosModules.connectivity.controldDns = {
    enable = mkEnableOption "Enable connectivity.controldDns";
  };

  config = mkIf cfg.enable {
    networking.nameservers = [
      "76.76.2.2"
      "76.76.10.2"
      "2606:1a40::2"
      "2606:1a40:1::2"
    ];
  };
}

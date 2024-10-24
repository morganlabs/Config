{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.nixosModules.programs.games.steam;
in
with lib;
{
  options.nixosModules.programs.games.steam = {
    enable = mkEnableOption "Enable programs.games.steam";
  };

  config = mkIf cfg.enable {
    programs.steam = {
      enable = true;
      localNetworkGameTransfers.openFirewall = true;
      gamescopeSession.enable = true;
    };

    programs.gamescope = {
      enable = true;
      capSysNice = true;
    };
  };
}

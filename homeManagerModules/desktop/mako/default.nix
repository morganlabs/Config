{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.desktop.mako;
in
with lib;
{
  options.homeManagerModules.desktop.mako = {
    enable = mkEnableOption "Enable desktop.mako";
  };

  imports = [ ./config.nix ];
  config = mkIf cfg.enable {
    home.packages = with pkgs; [ libnotify ];
    services.mako.enable = true;
  };
}

{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.pfetch;
in
with lib;
{
  options.homeManagerModules.programs.pfetch = {
    enable = mkEnableOption "Enable programs.pfetch";
    features.autoRun.enable = mkBoolOption "Auto-run on all known shells" true;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ pfetch ];
    programs.zsh = {
      initExtra = mkIfStr cfg.features.autoRun.enable ''[[ "$IN_NIX_SHELL" == "" ]] && pfetch'';
      envExtra = ''
        export PF_INFO="title os kernel uptime pkgs editor wm"
        export PF_SEP=" "
      '';
    };
  };
}

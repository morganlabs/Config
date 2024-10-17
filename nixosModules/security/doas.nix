{
  config,
  pkgs,
  lib,
  vars,
  ...
}:
let
  cfg = config.nixosModules.security.doas;
in
with lib;
{
  options.nixosModules.security.doas = {
    enable = mkEnableOption "Enable security.doas";

    rules = mkListOfOption types.attrs "The rules for doas" [
      {
        groups = [ "wheel" ];
        keepEnv = true;
        persist = true;
      }
    ];
  };

  config = mkIf cfg.enable {
    security.doas = {
      enable = true;
      extraRules = cfg.rules;
    };

    security.sudo.enable = mkDefault false;
  };
}

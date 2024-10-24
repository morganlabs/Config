{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  cfg = config.homeManagerModules.programs.kitty;
  hasShellPackage = lib.hasPackage osConfig.environment.systemPackages;
in
with lib;
{
  options.homeManagerModules.programs.kitty = {
    enable = mkEnableOption "Enable programs.kitty";
  };

  config = mkIf cfg.enable {
    programs.kitty = {
      enable = true;
      themeFile = "GruvboxMaterialDarkMedium";

      shellIntegration.enableBashIntegration = hasShellPackage pkgs.bash;
      shellIntegration.enableZshIntegration = hasShellPackage pkgs.zsh;
      shellIntegration.enableFishIntegration = hasShellPackage pkgs.fish;

      settings = import ./config.nix { inherit config; };
    };
  };
}

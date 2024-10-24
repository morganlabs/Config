{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.desktop.rofi;
in
with lib;
{
  options.homeManagerModules.desktop.rofi = {
    enable = mkEnableOption "Enable desktop.rofi";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [ kora-icon-theme ];

    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;

      font = "BlexMono Nerd Font 16";
      theme = import ./theme.nix { inherit config; };
      extraConfig = import ./config.nix;
    };
  };
}

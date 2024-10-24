{
  config,
  pkgs,
  lib,
  osConfig,
  ...
}:
let
  cfg = config.homeManagerModules.desktop.waybar;
in
with lib;
{
  options.homeManagerModules.desktop.waybar = {
    enable = mkEnableOption "Enable desktop.waybar";

    bars.enable = mkBoolOption "Enable the Hyprland waybar" config.homeManagerModules.desktop.hyprland.enable;

    modules = {
      clock.enable = mkBoolOption "Enable the clock module" true;
      backlight.enable = mkBoolOption "Enable the backlight module" false;
      network.enable = mkBoolOption "Enable the network module" osConfig.networking.networkmanager.enable;
      pulseaudio.enable = mkBoolOption "Enable the pulseaudio module" osConfig.services.pipewire.pulse.enable;
      tray.enable = mkBoolOption "Enable the tray module" true;
      workspaces.enable = mkBoolOption "Enable the Hyprland workspaces module" config.homeManagerModules.desktop.hyprland.enable;
      window.enable = mkBoolOption "Enable the Hyprland window title module" config.homeManagerModules.desktop.hyprland.enable;

      battery = {
        enable = mkBoolOption "Enable the battery module" false;
        bat = mkStrOption "Which battery to monitor" "";
      };

      bluetooth = {
        enable = mkBoolOption "Enable the bluetooth module" osConfig.hardware.bluetooth.enable;
        controller = mkStrOption "WHich bluetooth controller to use" "";
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      builtins.concatLists [
        (mkIfList cfg.modules.bluetooth.enable [ blueman ])
        (mkIfList cfg.modules.pulseaudio.enable [
          pavucontrol
          pamixer
        ])
      ];

    programs.waybar = {
      enable = true;
      style = import ./style.nix { inherit config; };

      settings = [
        (mkIf cfg.bars.enable (
          import ./bars/hyprland.nix {
            inherit
              cfg
              lib
              config
              pkgs
              ;
          }
        ))
      ];
    };
  };
}

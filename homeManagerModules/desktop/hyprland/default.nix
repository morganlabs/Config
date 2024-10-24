{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cfg = config.homeManagerModules.desktop.hyprland;

  variables = {
    "$mod" = "SUPER";
    "$alt" = "ALT";
  };
in
with lib;
{
  options.homeManagerModules.desktop.hyprland = {
    enable = mkEnableOption "Enable desktop.hyprland";
    features.startOnLogin.enable = mkBoolOption "Auto-start Hyprland from the TTY" true;

    config = {
      extra = mkAttrsOption "Extra configuration" { };

      includeDefault = {
        binds = mkBoolOption "Keep default binds config" true;
        inputs = mkBoolOption "Keep default inputs config" true;
        windowRules = mkBoolOption "Keep default windowRules config" true;
        decoration = mkBoolOption "Keep default decoration config" true;
        env = mkBoolOption "Keep default env config" true;
        autostart = mkBoolOption "Keep default autostart config" true;
      };
    };

    functions = {
      screenshot.enable = mkBoolOption "Enable the screenshot function" true;
      musicControl.enable = mkBoolOption "Enable the music control function" true;
      volume.enable = mkBoolOption "Enable the volume function" true;
      brightness.enable = mkBoolOption "Enable the brightness function" false;
    };
  };

  imports = [
    ./config/binds.nix
    ./config/inputs.nix
    ./config/windowRules.nix
    ./config/decoration.nix
    ./config/env.nix
    ./config/autostart.nix

    ./functions/brightness.nix
    ./functions/volume.nix
    ./functions/musicControl.nix
    ./functions/screenshot.nix
  ];

  config = mkIf cfg.enable (mergeManyAttrsets [
    {
      home.packages = with pkgs; [
        # (writeShellScriptBin "reset-portals" (import ./scripts/resetPortals.nix { inherit pkgs; }))
        wl-clipboard
        kdePackages.polkit-kde-agent-1
      ];

      gtk = import ./config/gtk.nix { inherit pkgs; };

      wayland.windowManager.hyprland = {
        enable = true;
        xwayland.enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

        settings = mkMerge [
          variables
          cfg.config.extra
        ];
      };

      home = {
        sessionVariables.NIXOS_OZONE_WL = "1"; # Hint electron apps to use Wayland
        pointerCursor = import ./config/cursor.nix { inherit pkgs; };
      };

      # xdg.portal = {
      #   enable = true;
      #   xdgOpenUsePortal = true;
      #   config.common.default = "hyprland";
      #   extraPortals = with pkgs; [
      #     xdg-desktop-portal-hyprland
      #     xdg-desktop-portal-gtk
      #   ];
      # };
    }
  ]);
}

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

  mkStartOnLoginSnippet =
    shell: snippet:
    lib.mkIf (
      cfg.features.startOnLogin.enable && builtins.elem shell cfg.features.startOnLogin.shells
    ) snippet;
in
with lib;
{
  options.homeManagerModules.desktop.hyprland = {
    enable = mkEnableOption "Enable desktop.hyprland";
    extra.binds = mkListOfOption types.str "Additional Bindings" [ ];

    config = {
      includeDefault = mkBoolOption "Keep the default configuration" true;
      extra = mkAttrsOption "Extra configuration" { };
    };

    features.startOnLogin = {
      enable = mkBoolOption "Auto-start Hyprland from the TTY" true;
      shells = mkListOfOption types.str "A list of shells that Hyprland should autostart from" [ "zsh" ];
    };

    functions = {
      screenshot.enable = mkBoolOption "Enable the screenshot function" true;
      musicControl.enable = mkBoolOption "Enable the music control function" true;
      volume.enable = mkBoolOption "Enable the volume function" true;
      brightness.enable = mkBoolOption "Enable the brightness function" false;
    };
  };

  config = mkIf cfg.enable (
    (mkIf cfg.config.includeDefault {
      imports = [
        ./config/binds.nix
        ./config/inputs.nix
        ./config/windowRules.nix
        ./config/decoration.nix
        ./config/env.nix
        ./config/autostart.nix
      ];
    })
    // (mkIf cfg.functions.brightness.enable (import ./functions/brightness.nix { inherit pkgs; }))
    // (mkIf cfg.functions.volume.enable (import ./functions/volume.nix { inherit pkgs; }))
    // (mkIf cfg.functions.musicControl.enable (import ./functions/musicControl.nix { inherit pkgs; }))
    // (mkIf cfg.functions.screenshot.enable (import ./functions/screenshot.nix { inherit pkgs; }))
    // {
      home.packages = with pkgs; [
        # (writeShellScriptBin "reset-portals" (import ./scripts/resetPortals.nix { inherit pkgs; }))
        wl-clipboard
        kdePackages.polkit-kde-agent-1
      ];

      gtk = import ./config/gtk.nix { inherit pkgs; };
      programs.zsh.initExtra = mkStartOnLoginSnippet "zsh" ''
        if [ -z "''${WAYLAND_DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
        dbus-run-session Hyprland
        fi
      '';

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
  );
}

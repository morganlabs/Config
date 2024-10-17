{
  config,
  pkgs,
  lib,
  inputs,
  ...
}:
let
  cfg = config.homeManagerModules.desktop.hyprland;

  defaultBinds = (import ./binds.nix { inherit pkgs; });
  defaultInputs = (import ./inputs.nix { inherit pkgs; });
  defaultWindowRules = (import ./windowRules.nix { inherit pkgs; });
  defaultDecoration = (import ./decoration.nix { inherit pkgs config; });
  defaultEnv = (import ./env.nix { inherit pkgs; });
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
      brightness.enable = mkBoolOption "Enable the brightness function" false;
      volume.enable = mkBoolOption "Enable the volume function" false;
      screenshot.enable = mkBoolOption "Enable the screenshot function" false;
      musicControl.enable = mkBoolOption "Enable the music control function" true;
    };
  };

  config = mkIf cfg.enable {
    home.packages =
      with pkgs;
      builtins.concatLists [
        [
          # (writeShellScriptBin "reset-portals" (import ./scripts/resetPortals.nix { inherit pkgs; }))
          dconf
          wl-clipboard
          wev
          kdePackages.polkit-kde-agent-1
        ]
        (mkIfList cfg.functions.brightness.enable [ brightnessctl ])
        (mkIfList cfg.functions.volume.enable [ pamixer ])
        (mkIfList cfg.functions.musicControl.enable [ playerctl ])
        (mkIfList cfg.functions.screenshot.enable [
          (writeShellScriptBin "screenshot" (builtins.readFile ./scripts/screenshot.sh))
          slurp
          grim
          jq
        ])
      ];

    wayland.windowManager.hyprland = {
      enable = true;
      xwayland.enable = true;
      package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;

      settings = mkMerge [
        {
          "$mod" = "SUPER";
          "$alt" = "ALT";
        }
        (mkIf cfg.config.includeDefault (mkMerge [
          defaultBinds
          defaultInputs
          defaultWindowRules
          defaultDecoration
          defaultEnv
        ]))
        (mkIf cfg.functions.brightness.enable {
          bind = [
            ", XF86MonBrightnessUp, exec, brightnessctl set +5%"
            ", XF86MonBrightnessDown, exec, brightnessctl set 5%-"
          ];
        })
        (mkIf cfg.functions.volume.enable {
          bind = [
            ", XF86AudioRaiseVolume, exec, pamixer -i 5"
            ", XF86AudioLowerVolume, exec, pamixer -d 5"
            ", XF86AudioMute, exec, pamixer --toggle-mute"
          ];
        })
        (mkIf cfg.functions.screenshot.enable {
          bind = [
            "ALT SHIFT, 1, exec, screenshot selection"
            "ALT SHIFT, 2, exec, screenshot window"
            "ALT SHIFT, 3, exec, screenshot all"
          ];
        })
        cfg.config.extra
      ];
    };

    programs.zsh.initExtra =
      mkIf (cfg.features.startOnLogin.enable && builtins.elem "zsh" cfg.features.startOnLogin.shells)
        ''
          if [ -z "''${WAYLAND_DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
            dbus-run-session Hyprland
          fi
        '';

    # xdg.portal = {
    #   enable = true;
    #   xdgOpenUsePortal = true;
    #   config.common.default = "hyprland";
    #   extraPortals = with pkgs; [
    #     xdg-desktop-portal-hyprland
    #     xdg-desktop-portal-gtk
    #   ];
    # };

    home = {
      sessionVariables.NIXOS_OZONE_WL = "1"; # Hint electron apps to use Wayland

      pointerCursor = {
        gtk.enable = true;
        package = pkgs.bibata-cursors;
        name = "Bibata-Modern-Classic";
        size = 16;
      };
    };

    gtk = {
      enable = true;

      theme = {
        package = pkgs.flat-remix-gtk;
        name = "Flat-Remix-GTK-Grey-Darkest";
      };

      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };

      font = {
        name = "Sans";
        size = 11;
      };
    };
  };
}

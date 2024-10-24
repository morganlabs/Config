{
  inputs,
  config,
  lib,
  pkgs,
  ...
}:
let
  cfg = config.homeManagerModules.programs.vesktop;
in
with lib;
{
  imports = [ inputs.nixcord.homeManagerModules.nixcord ];

  options.homeManagerModules.programs.vesktop = {
    enable = mkEnableOption "Enable programs.vesktop";

    features.discover.enable = mkBoolOption "Enable Discover overlay" true;
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; mkIfList cfg.features.discover.enable [ discover-overlay ];

    home.activation.setupDiscoverConfig =
      let
        defaultConfig = builtins.readFile ./discover_config.ini;
      in
      lib.hm.dag.entryAfter [ "writeBoundary" ] ''
        CONFIG_FILE="$HOME/.config/discover_overlay/config.ini"
        mkdir -p "$(dirname "$CONFIG_FILE")"
        echo "${defaultConfig}" > "$CONFIG_FILE"
      '';

    programs.nixcord = {
      enable = true;
      discord.enable = false;
      vesktop.enable = true;

      config = {
        frameless = true;
        plugins = {
          betterGifPicker.enable = true;
          callTimer.enable = true;
          betterUploadButton.enable = true;
          clearURLs.enable = true;
          disableCallIdle.enable = true;
          favoriteGifSearch.enable = true;
          forceOwnerCrown.enable = true;
          fullSearchContext.enable = true;
          moreCommands.enable = true;
          noF1.enable = true;
          noUnblockToJump.enable = true;
          platformIndicators.enable = true;
          openInApp.enable = true;
          newGuildSettings.enable = true;
          unindent.enable = true;
          volumeBooster.enable = true;

          showMeYourName = {
            enable = true;
            # displayNames = true;
            # inReplies = true;
          };

          consoleJanitor = {
            enable = true;
            disableLoggers = true;
            disableSpotifyLogger = true;
          };
        };
      };
    };
  };
}

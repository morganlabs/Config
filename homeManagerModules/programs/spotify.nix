{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.programs.spotify;
in
with lib;
{
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  options.homeManagerModules.programs.spotify = {
    enable = mkEnableOption "Enable programs.spotify";
  };

  config = mkIf cfg.enable {
    programs.spicetify =
      let
        spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.system};
      in
      {
        enable = true;
        theme = spicePkgs.themes.dribbblish;
        colorScheme = "gruvbox-material-dark";
        enabledExtensions = with spicePkgs.extensions; [
          autoSkipVideo
          popupLyrics
          shuffle
          lastfm
          savePlaylists
          beautifulLyrics
        ];
      };
  };
}

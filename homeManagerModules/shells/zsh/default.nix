{
  config,
  pkgs,
  lib,
  ...
}:
let
  cfg = config.homeManagerModules.shells.zsh;

  defaultPlugins = import ./plugins.nix { inherit pkgs; };
  defaultAliases = import ./aliases.nix;
  defaultAbbreviations = import ./abbreviations.nix;
  defaultSessionVariables = import ./sessionVariables.nix;
  defaultFunctions = import ./functions.nix { inherit pkgs; };

  finalAliases = lib.mkIfElse cfg.config.includeDefault.aliases (
    defaultAliases // cfg.config.extra.aliases
  ) cfg.config.extra.aliases;

  finalAbbreviations = lib.mkIfElse cfg.config.includeDefault.abbreviations (
    defaultAbbreviations // cfg.config.extra.abbreviations
  ) cfg.config.extra.abbreviations;

  finalPlugins = lib.mkIfElse cfg.config.includeDefault.plugins (
    defaultPlugins.plugins ++ cfg.config.extra.plugins
  ) cfg.config.extra.plugins;

  finalSessionVariables = lib.mkIfElse cfg.config.includeDefault.sessionVariables (
    defaultSessionVariables // cfg.config.extra.sessionVariables
  ) cfg.config.extra.sessionVariables;

  finalFunctions = lib.mkIfElse cfg.config.includeDefault.functions (lib.strings.concatStrings [
    defaultFunctions
    cfg.config.extra.functions
  ]) cfg.config.extra.functions;
in
with lib;
{
  options.homeManagerModules.shells.zsh = {
    enable = mkEnableOption "Enable shells.zsh";

    config = {
      prompt = mkStrOption "The PROMPT value" (
        with config.colorScheme.palette; "%B%F{#${base0E}%}%3~>%b%{$reset_color%} "
      );

      extra = {
        plugins = mkListOfOption types.str "Keep default plugins" [ ];
        aliases = mkAttrsOption "Keep default aliases" { };
        abbreviations = mkAttrsOption "Keep default abbreviations" { };
        sessionVariables = mkAttrsOption "Keep default session variables" { };
        functions = mkStrOption "Keep default functions" "";
        config = mkStrOption "Extra config" ''
          setopt HIST_FIND_NO_DUPS
          setopt INC_APPEND_HISTORY
        '';
      };

      includeDefault = {
        plugins = mkBoolOption "Keep default plugins" true;
        aliases = mkBoolOption "Keep default aliases" true;
        abbreviations = mkBoolOption "Keep default abbreviations" true;
        sessionVariables = mkBoolOption "Keep default session variables" true;
        functions = mkBoolOption "Keep default functions" true;
      };
    };
  };

  config = mkIf cfg.enable {
    home.packages = mkIfList cfg.config.includeDefault.plugins defaultPlugins.pluginPkgs;

    homeManagerModules.programs =
      mkIf (cfg.config.includeDefault.aliases && cfg.config.includeDefault.abbreviations)
        {
          eza.enable = true;
          bat.enable = true;
          nvim.enable = true;
          git.enable = true;
          pfetch.enable = true;
        };

    programs.zsh = {
      enable = true;
      autocd = true;
      sessionVariables = finalSessionVariables;
      shellAliases = finalAliases // finalAbbreviations;
      initExtraBeforeCompInit = concatStringsSep "\n" (map (item: "source \"${item}\"") finalPlugins);
      zsh-abbr = {
        enable = true;
        abbreviations = finalAbbreviations;
      };

      initExtra = strings.concatStringsSep "\n" [
        cfg.config.extra.config
        finalFunctions

        (mkIfStr config.homeManagerModules.desktop.hyprland.features.startOnLogin.enable ''
          if [ -z "''${WAYLAND_DISPLAY}" ] && [ "''${XDG_VTNR}" -eq 1 ]; then
            dbus-run-session Hyprland
          fi
        '')

        (mkIfStr cfg.config.includeDefault.plugins ''
          bindkey '^[[A' history-substring-search-up
          bindkey '^[[B' history-substring-search-down
        '')
        ''
          PROMPT="${cfg.config.prompt}"
          [[ "$IN_NIX_SHELL" != "" ]] && RPROMPT="develop"
        ''
      ];
    };
  };
}

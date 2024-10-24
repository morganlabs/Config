{ inputs, vars, ... }:
{
  imports = [ inputs.nix-colors.homeManagerModules.default ];

  # https://github.com/tinted-theming/base16-schemes/blob/main/gruvbox-dark-medium.yaml
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-material-dark-medium;
  programs.home-manager.enable = true;

  home = {
    username = vars.user.username;
    homeDirectory = "/home/${vars.user.username}";
  };

  homeManagerModules = {
    shells.zsh.enable = true;
    desktop.waybar.enable = true;

    desktop = {
      hyprland.enable = true;
      hyprlock.enable = true;
      rofi.enable = true;
    };

    programs = {
      kitty.enable = true;
      firefox.enable = true;
      obsidian.enable = true;
      slack.enable = true;
      betterbird.enable = true;
      git.enable = true;
      vesktop.enable = true;
      joshuto.enable = true;
      man.enable = true;
      unzip.enable = true;
      vimv.enable = true;
      # figma.enable = true;
      feishin.enable = true;
      spotify.enable = true;
    };
  };
}

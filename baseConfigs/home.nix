{ inputs, vars, ... }:
{
  imports = [ inputs.nix-colors.homeManagerModules.default ];

  # https://github.com/tinted-theming/base16-schemes/blob/main/gruvbox-dark-medium.yaml
  colorScheme = inputs.nix-colors.colorSchemes.gruvbox-dark-medium;

  home = {
    username = vars.user.username;
    homeDirectory = "/home/${vars.user.username}";
  };

  programs.home-manager.enable = true;

  homeManagerModules = {
    desktop.hyprland.enable = true;
  };
}

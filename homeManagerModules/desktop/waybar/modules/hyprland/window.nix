{ ... }:
{
  programs.waybar.settings = [
    {
      "hyprland/window" = {
        format = "{initialTitle}";
        separate-outputs = true;
        rewrite = {
          kitty = "Kitty";
          " - (.*)" = "$1";
          "- (.*)" = "$1";
          "Mozilla (.*)" = "$1";
          ".* - Discord" = "Discord";
          ".* - Lunar Client" = "Lunar Client";
        };
      };
    }
  ];
}

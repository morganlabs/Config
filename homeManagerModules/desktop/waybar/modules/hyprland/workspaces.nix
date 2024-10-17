{ ... }:
{
  programs.waybar.settings = [
    {
      "hyprland/workspaces" = {
        format = "{icon}{id}";
        format-icons = {
          default = "";
          urgent = " ";
        };
      };
    }
  ];
}

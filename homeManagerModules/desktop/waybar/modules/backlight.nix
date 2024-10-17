{ ... }:
{
  programs.waybar.settings = [
    {
      backlight = {
        format = "{icon} {percent}%";
        tooltip = false;
        scroll-step = 5;
        reverse-scrolling = true;
        format-icons = [
          "󰃞"
          "󰃞"
          "󰃝"
          "󰃝"
          "󰃟"
          "󰃟"
          "󰃟"
          "󰃟"
          "󰃠"
          "󰃠"
        ];
      };
    }
  ];
}

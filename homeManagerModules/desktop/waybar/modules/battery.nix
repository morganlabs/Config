{ cfg, ... }:
{
  programs.waybar.settings = [
    {
      battery = {
        inherit (cfg.modules.battery) bat;
        interval = 2;
        format = "{icon} {capacity}%";
        format-charging = "󱐋 {capacity}%";
        states = {
          charged = 100;
          default = 99;
          warning = 20;
          critical = 10;
        };
        format-icons = [
          "󰁺"
          "󰁻"
          "󰁼"
          "󰁽"
          "󰁾"
          "󰁿"
          "󰂀"
          "󰂁"
          "󰂂"
          "󰁹"
        ];
      };
    }
  ];
}

{ cfg, pkgs, ... }:
{
  home.packages = with pkgs; [ blueman ];

  programs.waybar.settings = [
    {
      bluetooth = {
        inherit (cfg.modules.bluetooth) controller;
        on-click = "blueman-manager";
        format = " {status}";
        format-on = " On";
        format-off = "󰂲 Off";
        format-disabled = "󰂲 Disabled";
        format-connected = "󰂱 Connected";
        tooltip-format-connected = "{device_alias}";
      };
    }
  ];
}

{ ... }:
{
  programs.waybar.settings = [
    {
      network = {
        format = "{icon} {essid}";
        format-wifi = "󰤨 {signalStrength}%";
        format-ethernet = "󰈀";
        format-disconnected = "󰤮 Disconnected";
        tooltip-format-wifi = "{essid} ({ipaddr})";
        tooltip-format-ethernet = "{ipaddr}";
      };
    }
  ];
}

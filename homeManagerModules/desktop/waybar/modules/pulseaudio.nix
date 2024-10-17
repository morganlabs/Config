{ pkgs, ... }:
{
  home.packages = with pkgs; [
    pavucontrol
    pamixer
  ];

  programs.waybar.settings = [
    {
      pulseaudio = with pkgs; {
        format = "{icon} {volume}%";
        format-muted = "󰝟";

        on-click = "${pavucontrol}/bin/pavucontrol";
        on-scroll-up = "${pamixer}/bin/pamixer -i 5";
        on-scroll-down = "${pamixer}/bin/pamixer -d 5";
        on-click-right = "${pamixer}/bin/pamixer --toggle-mute";

        format-icons = {
          default = "󰕾";
          headphone = "󰋋";
          headset = "󰋋";
          speaker = "󰓃";
        };
      };
    }
  ];
}

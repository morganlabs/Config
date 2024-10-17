{ config, ... }:
{
  programs.waybar.settings = [
    {
      clock = with config.colorScheme.palette; {
        format = "<span color='#${base0E}'>{:%a</span> %e %b <span color='#${base0E}'>%H</span>:%M}";
        interval = 5;
        tooltip = false;
      };
    }
  ];
}

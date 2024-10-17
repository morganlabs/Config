{ config, ... }:
{
  wayland.windowManager.hyprland.settings = with config.colorScheme.palette; {
    animations.enabled = false;

    general = {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;

      "col.active_border" = "rgb(${base0E})";
      "col.inactive_border" = "rgb(${base01})";

      resize_on_border = false;
      extend_border_grab_area = true;
      allow_tearing = false;
      layout = "dwindle";
    };

    decoration = {
      rounding = 0;
      active_opacity = 1.0;
      inactive_opacity = 1.0;

      drop_shadow = true;
      shadow_range = 0;
      shadow_offset = "4 4";
      "col.shadow" = "rgba(0, 0, 0, 0.5)";

      blur.enabled = false;
    };

    misc = {
      force_default_wallpaper = 0;
      disable_hyprland_logo = true;
      middle_click_paste = false;

      background_color = "rgb(${base00})";
    };
  };
}

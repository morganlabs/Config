{ config }:
let
  mkLabel =
    text: font_size: position: halign: valign: extra:
    with config.colorScheme.palette;
    {
      inherit
        text
        font_size
        position
        halign
        valign
        ;
      monitor = "";
      font_family = "BlexMono Nerd Font";
      color = "rgb(${base04})";
    }
    // extra;
in
with config.colorScheme.palette;
{
  general = {
    hide_cursor = true;
    grace = 10;
    ignore_empty_input = true;
  };

  background.color = "rgb(${base00})";

  label = [
    (mkLabel "$TIME" 64 "0, -160" "center" "top")
    (mkLabel ''cmd[update:1000] echo "$(date +'%A, %d %B')"'' 20 "0, -128" "center" "top")
  ];

  input-field = [
    {
      monitor = "";
      size = "512, 50";
      outline_thickness = 2;

      dots_size = 2.0e-2;
      dots_spacing = 0.2;
      dots_center = true;
      dots_rounding = 0;

      inner_color = "rgb(${base00})";
      outer_color = "rgb(${base00})";
      font_color = "rgb(${base04})";

      fade_on_empty = false;

      placeholder_text = "";

      rounding = 0;

      check_color = "rgb(${base09})";
      fail_color = "rgb(${base08})";
      fail_text = "<i>$FAIL <b>($ATTEMPTS)</b></i>";
      fail_transition = 256;

      capslock_color = "rgb(${base0E})";
      numlock_color = "rgb(${base0C})";
      bothlock_color = "rgb(${base0D})";

      position = "0, 128";
      halign = "center";
      valign = "bottom";
    }
  ];
}

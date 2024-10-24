{ timeoutUntil }:
{
  general = {
    lock_cmd = "pidof hyprlock || hyprlock";
    before_sleep_cmd = "loginctl lock-session";
    after_sleep_cmd = "hyprctl dispatch dpms on";
  };

  listener = [
    {
      timeout = timeoutUntil.lock;
      on-timeout = "hyprlock";
    }
    {
      timeout = timeoutUntil.sleep;
      on-timeout = "hyprctl dispatch dpms off";
      on-resume = "hyprctl dispatch dpms on";
    }
  ];

}

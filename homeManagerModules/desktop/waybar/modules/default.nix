{ ... }:
{
  imports = [
    ./network.nix
    ./bluetooth.nix
    ./tray.nix
    ./backlight.nix
    ./battery
    ./pulseaudio.nix
    ./clock.nix
    ./hyprland/workspaces.nix
    ./hyprland/window.nix
  ];
}

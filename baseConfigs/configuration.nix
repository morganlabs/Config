{ hostname, ... }:
{
  nixosModules = {
    boot.grub.enable = true;
    basic = {
      locale.enable = true;
      default = {
        user.enable = true;
        fonts.enable = true;
      };
    };

    connectivity = {
      networkmanager.enable = true;
      controldDns.enable = true;
      bluetooth.enable = true;
      firewall.enable = true;
    };

    services = {
      ssh.enable = true;
    };

    sound = {
      pipewire.enable = true;
      noisetorch.enable = true;
    };

    power = {
      thermald.enable = true;
      tlp.enable = true;
    };

    security = {
      doas.enable = true;
      polkit.enable = true;
      rtkit.enable = true;
      gnome-keyring.enable = true;
    };

    programs._1password.enable = true;
    desktop.hyprland.enable = true;
  };

  networking.hostName = hostname;
}

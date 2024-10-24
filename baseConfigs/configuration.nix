{
  hostname,
  logicalCores,
  memorySize,
  ...
}:
{
  nixosModules = {
    boot.grub.enable = true;
    basic = {
      locale.enable = true;
      default = {
        fonts.enable = true;
        nix.enable = true;
        user = {
          enable = true;
          features.autologin.enable = true;
        };
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

    programs = {
      _1password.enable = true;
      git.enable = true;
    };
    desktop.hyprland.enable = true;
  };

  virtualisation.vmVariant.virtualisation = {
    memorySize = builtins.floor ((memorySize * 0.25) * 1024);
    cores = builtins.floor (logicalCores * 0.25);
  };

  networking.hostName = hostname;
}

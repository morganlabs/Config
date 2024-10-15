{ hostname, ... }:
{
  nixosModules = {
    boot.grub.enable = true;
    basic.defaultUser.enable = true;

    connectivity = {
      networkmanager.enable = true;
      controldDns.enable = true;
      bluetooth.enable = true;
      firewall.enable = true;
    };

    services = {
      ssh.enable = true;
    };
  };

  networking.hostName = hostname;
}

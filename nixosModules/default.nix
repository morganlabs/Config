{ ... }:
{
  imports = [
    ./basic/defaultUser.nix

    ./connectivity/networkmanager.nix
    ./connectivity/controld.nix
    ./connectivity/bluetooth.nix
    ./connectivity/firewall.nix

    ./services/ssh.nix

    ./boot/grub.nix
  ];
}

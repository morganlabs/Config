{ ... }:
{
  imports = [
    ./basic/locale.nix
    ./basic/default/user.nix
    ./basic/default/fonts.nix

    ./connectivity/networkmanager.nix
    ./connectivity/controld.nix
    ./connectivity/bluetooth.nix
    ./connectivity/firewall.nix

    ./services/ssh.nix

    ./security/doas.nix
    ./security/polkit.nix
    ./security/rtkit.nix

    ./power/thermald.nix
    ./power/tlp.nix

    ./boot/grub.nix

    ./programs/1password.nix

    ./desktop/hyprland.nix
  ];
}

{ ... }:
{
  imports = [
    ./hardware-configuration.nix
    ./luks.nix
  ];

  # nixosModules =
  #   {
  #   };
  system.stateVersion = "24.05";
}

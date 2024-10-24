{ ... }:
{
  imports = [
    ./luks.nix
  ];

  nixosModules = {
    programs.games.steam.enable = true;
  };

  system.stateVersion = "24.05";
}

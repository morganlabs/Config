{
  inputs,
  vars,
  nixpkgs,
  home-manager,
  ...
}:
let
  mkSystem =
    {
      hostname,
      logicalCores,
      memorySize, # In GB
      system ? "x86_64-linux",
      includeBase ? true,
      extraArgs ? [ ],
    }:
    let
      overlays = (import ./overlays { inherit inputs; });

      pkgs = import nixpkgs {
        inherit system overlays;
        config.allowUnfree = true;
      };

      lib = pkgs.lib.extend (final: prev: home-manager.lib // prev // (import ./lib { lib = final; }));
    in
    nixpkgs.lib.nixosSystem {
      inherit system pkgs;

      specialArgs = {
        inherit
          inputs
          system
          vars
          hostname
          extraArgs
          lib
          logicalCores
          memorySize
          ;
      };

      modules = [
        ./nixosModules
        (lib.mkIfStr includeBase ./baseConfigs/configuration.nix)
        (./hosts + "/${hostname}/configuration.nix")
        (./hosts + "/${hostname}/hardware-configuration.nix")
        (import ./home-manager.nix { inherit includeBase hostname; })
      ];
    };
in
mkSystem

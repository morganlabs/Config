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
          ;
      };

      modules = [
        ./nixosModules
        (if includeBase then ./baseConfigs/configuration.nix else "")
        (./hosts + "/${hostname}/configuration.nix")
        (import ./home-manager.nix {
          inherit
            inputs
            vars
            pkgs
            includeBase
            hostname
            ;
        })
      ];
    };
in
mkSystem

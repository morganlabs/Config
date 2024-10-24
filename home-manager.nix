{ includeBase, hostname }:
{
  inputs,
  vars,
  lib,
  ...
}:
with lib;
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs vars;
    };

    users.${vars.user.username} = mkMerge [
      (mkIfStr includeBase ./baseConfigs/home.nix)
      (./hosts + "/${hostname}/home.nix")
      inputs.self.outputs.homeManagerModules.default
    ];
  };
}

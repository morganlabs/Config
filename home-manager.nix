{
  inputs,
  vars,
  includeBase,
  pkgs,
  hostname,
  ...
}:
with pkgs.lib;
{
  imports = [ inputs.home-manager.nixosModules.home-manager ];
  home-manager = {
    useGlobalPkgs = true;
    useUserPackages = true;

    extraSpecialArgs = {
      inherit inputs vars;
    };

    users.${vars.user.username} = mkMerge [
      inputs.self.outputs.homeManagerModules.default
      # ./homeManagerModules
      (if includeBase then ./baseConfigs/home.nix else "")
      (./hosts + "/${hostname}/home.nix")
    ];
  };
}

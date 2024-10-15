{
  config,
  pkgs,
  lib,
  vars,
  ...
}:
let
  cfg = config.nixosModules.services.ssh;
in
with lib;
{
  options.nixosModules.services.ssh = {
    enable = mkEnableOption "Enable services.ssh";

    extra.allowedUsers =
      mkListOfOption types.str
        "Add extra allowed users to login to as SSH (NOTE: vars.user.username will always be included)."
        [ ];
  };

  config = mkIf cfg.enable {
    services.openssh = {
      enable = mkForce true;
      ports = [ vars.ssh.port ]; # TODO: Put into secret
      settings = {
        PermitRootLogin = mkForce "no";
        PasswordAuthentication = mkDefault false;
        AllowUsers = [ vars.user.username ] ++ cfg.extra.allowedUsers;
      };
    };
  };
}

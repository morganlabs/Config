{
  config,
  pkgs,
  lib,
  vars,
  ...
}:
let
  cfg = config.nixosModules.basic.default.user;
in
with lib;
{
  options.nixosModules.basic.default.user = {
    enable = mkEnableOption "Enable basic.default.user";

    features.autologin.enable = mkBoolOption "Enable autologin" false;

    user = {
      username = mkStrOption "The username" vars.user.username;
      fullName = mkStrOption "The full name of the user" vars.user.name;
    };

    packages = mkListOfOption types.package "Which packages should be installed" [ ];
    shell = mkPkgOption "Choose which shell the user should use" pkgs.zsh;
    extra.groups =
      mkListOfOption types.str
        "Which extra groups should the user be a part of? (NOTE: The default user will always be a part of `wheel`)"
        [ ];
  };

  config = mkIf cfg.enable {
    # Ony autologin on the first TTY
    systemd.services."getty@tty1" = mkIf cfg.features.autologin.enable {
      overrideStrategy = "asDropin";
      serviceConfig.ExecStart = [
        ""
        "@${pkgs.util-linux}/sbin/agetty agetty --login-program ${config.services.getty.loginProgram} --autologin ${cfg.user.username} --noclear --keep-baud %I 115200,38400,9600 $TERM"
      ];
    };

    users.users.${cfg.user.username} = {
      inherit (cfg) packages shell;
      extraGroups = [ "wheel" ] ++ cfg.extra.groups;
      description = cfg.user.fullName;
      isNormalUser = true;
      ignoreShellProgramCheck = true;
      initialPassword = "vmpassword";
    };
  };
}

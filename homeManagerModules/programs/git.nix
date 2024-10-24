{
  config,
  pkgs,
  lib,
  vars,
  osConfig,
  ...
}:
let
  cfg = config.homeManagerModules.programs.git;
in
with lib;
{
  options.homeManagerModules.programs.git = {
    enable = mkEnableOption "Enable programs.git";
    defaultBranch = mkStrOption "The default branch name" "main";

    features = {
      delta.enable = mkBoolOption "Enable Delta" true;
      onePasswordSigning.enable = mkBoolOption "Enable 1Password Commit Signing" osConfig.programs._1password-gui.enable;
    };

    user = {
      username = mkStrOption "Name" vars.user.name;
      email = mkStrOption "Email" vars.user.email;
    };
  };

  config = mkIf cfg.enable {
    programs.git = {
      enable = true;
      userName = cfg.user.username;
      userEmail = cfg.user.email;

      extraConfig = mkMerge [
        {
          init.defaultBranch = cfg.defaultBranch;
        }
        (mkIf cfg.features.onePasswordSigning.enable {
          user.signingkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIBNv1xhpJxFP8KP0+ai4+sK6HRu70J6Nq/u4dU27MixM";
          commit.gpgsign = true;
          gpg = {
            format = "ssh";
            ssh.program = "${lib.getExe' pkgs._1password-gui "op-ssh-sign"}";
          };
        })
      ];

      delta = mkIf cfg.features.delta.enable {
        enable = true;
        options = {
          core = {
            pager = "delta";
          };
          interactive = {
            diffFilter = "delta --color-only";
          };
          delta = {
            navigate = true;
          };
          merge = {
            conflictstyle = "diff3";
          };
          diff = {
            colorMoved = "default";
          };
        };
      };
    };

    programs.ssh = {
      enable = true;
      extraConfig = mkIfStr cfg.features.onePasswordSigning.enable ''
        Host *
          IdentityAgent ~/.1password/agent.sock
      '';
    };
  };
}

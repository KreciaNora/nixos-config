{ config, pkgs, lib, ... }:

with lib;

let
  cfg = config.services.ydotool;
in

{
  options.services.ydotool = {
    enable = mkOption {
      type = types.bool;
      default = false;
      description = "Enable ydotool support (uinput access for keyboard mouse control).";
    };
  };

  config = mkIf cfg.enable {
    # Load uinput kernel module
    boot.kernelModules = lib.mkForce (config.boot.kernelModules or []) ++ [ "uinput" ];

    # Add uinput device rule
    services.udev.extraRules = ''
      KERNEL=="uinput", GROUP="input", MODE="0660"
    '';

    # Add user to input group
    users.users = lib.mapAttrsToList (name: userCfg: {
      inherit name;
      extraGroups = (userCfg.extraGroups or []) ++ [ "input" ];
    }) config.users.users;
  };
}


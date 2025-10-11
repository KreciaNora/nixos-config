{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
  ];

  networking.hostName = "laptop-intel";

  home-manager.users.krecikowa = {
    imports = [ ../../home/waybar/waybar-intel.nix ];
  };
}

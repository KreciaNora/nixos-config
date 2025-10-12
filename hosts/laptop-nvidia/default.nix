{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ../../modules/nvidia.nix
  ];

  networking.hostName = "laptop-nvidia";

  modules.nvidia.enable = true;
  
  services.xampp.enable = true;

  home-manager.users.krecikowa = {
    imports = [ ../../home/waybar/waybar-nvidia.nix ];
  };
}

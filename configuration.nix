{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/hyprland.nix
    ./modules/gaming.nix
    ./modules/bootloader.nix
    ./modules/network.nix
    ./modules/locale.nix
    ./modules/desktop.nix
    ./modules/audio.nix
    ./modules/user.nix
    ./modules/packages.nix
    ./modules/hardwere.nix
    ./modules/nix.nix

  ];

}

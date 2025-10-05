{ config, pkgs, ... }:

{
  imports = [
    ./hardware-configuration.nix
    ./modules/nvidia.nix
    ./modules/hyprland.nix
    ./modules/gaming.nix
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernelPackages = pkgs.linuxPackages_6_12;

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Locale
  time.timeZone = "Europe/Warsaw";
  i18n.defaultLocale = "pl_PL.UTF-8";
  console.keyMap = "pl2";

  # Desktop
  services.xserver.enable = true;
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;
  services.xserver.xkb.layout = "pl";

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };

  # User
  users.users.krecikowa = {
    isNormalUser = true;
    description = "Krecikowa";
    extraGroups = [ "networkmanager" "wheel" ];
  };

  # Podstawowe pakiety
  environment.systemPackages = with pkgs; [
    neovim
    wget
    git
    firefox
    discord
    vscodium
    krita
  ];

  # Hardware
  hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true;
  };

  # Nix
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  nixpkgs.config.allowUnfree = true;

  system.stateVersion = "25.05";
}

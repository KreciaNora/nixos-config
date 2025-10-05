# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page

# and in the NixOS manual (accessible by running 'nixos-help').

{ config, pkgs, ... }:



{

 fonts.packages = with pkgs; [
  nerd-fonts.jetbrains-mono
] ++ builtins.filter lib.attrsets.isDerivation (builtins.attrValues pkgs.nerd-fonts); 
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Bootloader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Use latest kernel.
  boot.kernelPackages = pkgs.linuxPackages_6_12;
  
  # Kernel parameter dla NVIDIA + Wayland (WAŻNE!)
  boot.kernelParams = [ "nvidia-drm.modeset=1" ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

# Enable OpenTabletDriver
   hardware.opentabletdriver = {
    enable = true;
    daemon.enable = true; # uruchamia usługę użytkownika automatycznie
    # jeśli trzeba, można dodać blacklistę modułów jądra, np.:
    # blacklistedKernelModules = [ "wacom" "hid-uclogic" ];
  };
  # Enable networking
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Warsaw";

  # Select internationalisation properties.
  i18n.defaultLocale = "pl_PL.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "pl_PL.UTF-8";
    LC_IDENTIFICATION = "pl_PL.UTF-8";
    LC_MEASUREMENT = "pl_PL.UTF-8";
    LC_MONETARY = "pl_PL.UTF-8";
    LC_NAME = "pl_PL.UTF-8";
    LC_NUMERIC = "pl_PL.UTF-8";
    LC_PAPER = "pl_PL.UTF-8";
    LC_TELEPHONE = "pl_PL.UTF-8";
    LC_TIME = "pl_PL.UTF-8";
  };

  # Enable the X11 windowing system.
  services.xserver.enable = true;

  # Enable the GNOME Desktop Environment.
  services.xserver.displayManager.gdm.enable = true;
  services.xserver.desktopManager.gnome.enable = true;

  # Configure keymap in X11
  services.xserver.xkb = {
    layout = "pl";
    variant = "";
  };

  # Configure console keymap
  console.keyMap = "pl2";

  # Enable CUPS to print documents.
  services.printing.enable = true;

  # Enable sound with pipewire.
  services.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    # If you want to use JACK applications, uncomment this
    #jack.enable = true;

    # use the example session manager (no others are packaged yet so this is enabled by default,
    # no need to redefine it in your config for now)
    #media-session.enable = true;
  };
programs.steam = {
  enable = true;
  remotePlay.openFirewall = true; # Open ports in the firewall for Steam Remote Play
  dedicatedServer.openFirewall = true; # Open ports in the firewall for Source Dedicated Server
  localNetworkGameTransfers.openFirewall = true; # Open ports in the firewall for Steam Local Network Game Transfers
};
  # Enable touchpad support (enabled default in most desktopManager).
  # services.xserver.libinput.enable = true;

  # Define a user account. Don't forget to set a password with 'passwd'.
  users.users.krecikowa = {
    isNormalUser = true;
    description = "Krecikowa";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Install firefox.
  programs.firefox.enable = true;

  # ===== HYPRLAND =====
  programs.hyprland = {
    enable = true;
    xwayland.enable = true;  # Kompatybilność z aplikacjami X11
  };
  #flake
  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
  # List packages installed in system profile. To search, run:
  # $ nix search wget
  environment.systemPackages = with pkgs; [
    # Podstawowe narzędzia
    jdk
    gcc
    neovim
    wget
    git
    fastfetch
    inxi
    unrar
    unzip
    nemo
    lua
    nodejs
    github-desktop
    grim
    # Komunikacja
    discord
    signal-desktop   
    # Przeglądarki
    google-chrome
    # Gaming
    wine
    prismlauncher
    lutris
    steam
    steam-run
    osu-lazer
    
    # Development
    vscodium
    
    # Grafika i multimedia
    krita
    mesa-demos
    vulkan-tools
    libdrm
    libva
    libva-vdpau-driver
    libvdpau-va-gl
    mesa
    opentabletdriver	   
    # === HYPRLAND ESSENTIALS ===
    waybar              # Panel górny
    dunst               # Powiadomienia
    libnotify           # Wsparcie dla powiadomień
    rofi-wayland        # Launcher aplikacji
    kitty               # Terminal
    wofi
    # Tapety i screenshoty
    swww                # Tapety
    grim                # Screenshot (cały ekran)
    slurp               # Screenshot (zaznaczanie obszaru)
    wl-clipboard        # Schowek
    hyprpaper
    # Blokada ekranu
    swaylock-effects    # Ładna blokada ekranu
    
    # File manager
    xfce.thunar         # GUI file manager
    
    # Kontrola audio/brightness
    pavucontrol         # Kontrola dźwięku (GUI)
    brightnessctl       # Jasność ekranu
    
    # Polkit (uprawnienia GUI)
    polkit_gnome        # Żeby aplikacje mogły prosić o hasło
    
    # Network manager applet
    networkmanagerapplet
  ];

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;
  
  # NVIDIA Configuration
  services.xserver.videoDrivers = ["nvidia"];

  hardware.nvidia = {
    # Modesetting is required.
    modesetting.enable = true;

    # Nvidia power management. Experimental, and can cause sleep/suspend to fail.
    # Enable this if you have graphical corruption issues or application crashes after waking
    # up from sleep. This fixes it by saving the entire VRAM memory to /tmp/ instead
    # of just the bare essentials.
    powerManagement.enable = false;

    # Fine-grained power management. Turns off GPU when not in use.
    # Experimental and only works on modern Nvidia GPUs (Turing or newer).
    powerManagement.finegrained = false;

    # Use the NVidia open source kernel module (not to be confused with the
    # independent third-party "nouveau" open source driver).
    # Support is limited to the Turing and later architectures. Full list of
    # supported GPUs is at:
    # https://github.com/NVIDIA/open-gpu-kernel-modules#compatible-gpus
    # Only available from driver 515.43.04+
    open = false;

    # Enable the Nvidia settings menu,
    # accessible via `nvidia-settings`.
    nvidiaSettings = true;

    # Optionally, you may need to select the appropriate driver version for your specific GPU.
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Polkit dla Hyprland
  security.polkit.enable = true;

  # Automatyczny start polkit agent
  systemd.user.services.polkit-gnome-authentication-agent-1 = {
    description = "polkit-gnome-authentication-agent-1";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };

  # XDG Portal dla screen sharing (Discord, OBS, etc.)
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It's perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "25.05"; # Did you read the comment?
}

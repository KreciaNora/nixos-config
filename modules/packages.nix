{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    gtop
    gotop
    emacs
    tree
    nodejs
    qutebrowser
    neovim
    wget
    git
    firefox
    discord
    vscodium
    github-desktop
    krita
    transmission_4-gtk
    unzip
    kitty 
    unrar
    virtualbox
    signal-desktop
    fastfetch
    htop
    google-chrome
    btop
    jdk

    gcc
    gnumake
    cmake
    libtool
    autoconf
    automake
    pkg-config
  ];
}

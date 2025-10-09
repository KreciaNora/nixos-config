{ config, pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    tree
    vimb
    qutebrowser
    nyxt
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
  ];
}

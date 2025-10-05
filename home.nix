{ config, pkgs, ... }:

{
  home.username = "krecikowa";
  home.homeDirectory = "/home/krecikowa";
  home.stateVersion = "25.05";

  # Podstawowa konfiguracja git
  programs.git = {
    enable = true;
    userName = "Krecikowa";
    userEmail = "krecikowa01@gmail.com";  
  };

  # Bash aliases
  programs.bash = {
    enable = true;
    shellAliases = {
      ll = "ls -la";
      rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config";
      update = "cd ~/nixos-config && nix flake update && rebuild";
    };
  };
}

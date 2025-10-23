{ config, pkgs, ... }:

{


  programs.bash = {
    enable = true;
    enableCompletion = true;

    shellAliases = {
     ls = "eza";
     ll = "eza -la";
     rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config";
       update = "cd ~/nixos-config && nix flake update && rebuild";
       doomSync = "~/.config/emacs/bin/doom sync";
       
   };
    bashrcExtra = ''
    # Minimalistyczny prompt: ~ > lub <ścieżka> >
    PS1='\w > '
  '';
  };
}

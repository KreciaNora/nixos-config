{ config, pkgs, ... }:

{
  home.username = "krecikowa";
  home.homeDirectory = "/home/krecikowa";
  home.stateVersion = "25.05";

  home.file = {
    ".config/hypr".source = config.lib.file.mkOutOfStoreSymlink 
      "${config.home.homeDirectory}/nixos-config/dotfiles/hypr";

    ".config/waybar".source = config.lib.file.mkOutOfStoreSymlink 
      "${config.home.homeDirectory}/nixos-config/dotfiles/waybar";

    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink 
      "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";
  }; 
  imports = [
    ./home/kitty.nix
    
  ];
  

    programs.bash = {
    enable = true;
    enableCompletion = true;
    shellAliases = {
     ll = "ls -la";
     rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config";
       update = "cd ~/nixos-config && nix flake update && rebuild";
   };
  };

}

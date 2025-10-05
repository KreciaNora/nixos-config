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

    ".config/kitty".source = config.lib.file.mkOutOfStoreSymlink 
      "${config.home.homeDirectory}/nixos-config/dotfiles/kitty";
    "wallpapers/wallpaper.jpg".source = ./dotfiles/wallpapers/wallpaper.jpg;
  }; 



    programs.git = {
   enable = true;
   userName = "Krecikowa";
   userEmail = "krecikowa01@gmail.com";  
  };

  programs.bash = {
   enable = true;
   shellAliases = {
     ll = "ls -la";
     rebuild = "sudo nixos-rebuild switch --flake ~/nixos-config";
       update = "cd ~/nixos-config && nix flake update && rebuild";
   };
  };

}

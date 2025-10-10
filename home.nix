{ config, pkgs, ... }:

{
  home.username = "krecikowa";
  home.homeDirectory = "/home/krecikowa";
  home.stateVersion = "25.05";

  home.file = {

    ".config/nvim".source = config.lib.file.mkOutOfStoreSymlink 
      "${config.home.homeDirectory}/nixos-config/dotfiles/nvim";
  }; 
  imports = [
    ./home
    
  ];
  

   

}

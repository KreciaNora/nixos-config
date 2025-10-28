{ config, pkgs, ... }:
{
  imports = [
    ./kitty/kitty.nix
    ./bash/bash.nix
    ./hyprland/hyprland.nix
#    ./nvim/nvim.nix
    ./cursore/cursore.nix
    
  ];
}

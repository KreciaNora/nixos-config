{ config, lib, pkgs, ... }:
{
  imports = [
    ./modules
  ];

   fonts.packages = with pkgs; [
    emacs-all-the-icons-fonts
  ];
}

{ config, pkgs, ... }:
{

  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    options = {
      number = true;
      relativenumber = true;
    };
  };
}

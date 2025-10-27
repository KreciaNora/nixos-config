{ config, pkgs, ... }:
{

  programs.nixvim = {
    enable = true;
    options = {
      number = true;
      relativenumber = true;
    };
  };
}

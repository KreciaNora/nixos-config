{ config, pkgs, ... }:
{
  config = {
    programs.nixvim = {
      enable = true;
      options = {
        number = true;
        relativenumber = true;
      };
    };
  };
}

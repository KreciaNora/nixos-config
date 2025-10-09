{ config, pkgs, ... }:
{
  users.users.krecikowa = {
    isNormalUser = true;
    description = "Krecikowa";
    extraGroups = [ "networkmanager" "wheel" ];
  };

}

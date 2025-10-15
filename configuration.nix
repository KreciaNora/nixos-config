{ config, lib, pkgs, ... }:
{
  imports = [
    ./modules
  ];

  fonts.packages = with pkgs; [
    corefonts  # Zawiera Comic Sans MS i inne fonty Microsoft

    (pkgs.stdenv.mkDerivation {
      pname = "comic-mono";
      version = "1.0";
      src = pkgs.fetchurl {
        url = "https://github.com/dtinth/comic-mono-font/raw/master/ComicMono.ttf";
        sha256 = "sha256-O8FCXpIqFqvw7HZ+/+TQJoQ5tMDc6YQy4H0V9drVcZY=";
      };
      dontUnpack = true;
      installPhase = ''
        mkdir -p $out/share/fonts/truetype
        cp $src $out/share/fonts/truetype/
      '';
    })
  ];

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      serif = [ "Comic Sans MS" ];
      sansSerif = [ "Comic Sans MS" ];
      monospace = [ "Comic Mono" ];
    };
  };

  environment.systemPackages = with pkgs; [
    betterdiscordctl
    discord
  ];
}

